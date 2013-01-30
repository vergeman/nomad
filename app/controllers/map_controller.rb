class MapController < ApplicationController

def home

  @graph = nil

  if current_user

    @access_token  = @current_user.access_token

    puts "Access Token: \n#{@access_token}"
    begin

      @graph = Koala::Facebook::API.new(@access_token)

      @profile = @graph.get_object("me")

      # @friends = @graph.fql_query("SELECT uid, name, current_location, hometown_location FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me())")

      query1 = "SELECT uid, name, current_location.id, hometown_location.id "\
      "FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me())"

      query2 = "SELECT page_id, name, location.latitude, location.longitude "\
      "FROM page WHERE page_id IN (SELECT current_location.id FROM #query1)"
      
      query3 = "SELECT page_id, name, location.latitude, location.longitude "\
      "FROM page WHERE page_id IN (SELECT hometown_location.id FROM #query1)"

      @results = @graph.fql_multiquery({"query1" => query1,
                                     "query2" => query2,
                                     "query3" => query3}) 


    rescue => error
      session[:user_id] = nil
      # add flash for logout timeout here
      redirect_to root_path
    else

      #===unroll queries====
      @locations = Hash.new()

      @results['query3'].each do |l|
        @locations[l['page_id']] = {
          :name => !l['name'].nil? ? l['name'] : '',
          :latitude => !l['location'].empty?  ? l['location']['latitude'] : '',
          :longitude => !l['location'].empty? ? l['location']['longitude'] : ''
        }

      end

      @results['query2'].each do |l|
        @locations[l['page_id']] = {
          :name => !l['name'].nil? ? l['name'] : '',
          :latitude => !l['location'].empty?  ? l['location']['latitude'] : '',
          :longitude => !l['location'].empty? ? l['location']['longitude'] : ''
        }
      end

      #populate database
      logger.debug(@locations)

      @locations.each do |k, v|
        
        place = Location.find_or_initialize_by_loc_id(:loc_id => k, :name => v[:name], :lat => v[:latitude], :long => v[:longitude])

        if place.valid?
          logger.debug("saving place...")
          place.save!
        end
      end


      #===Friends Datastore===

      # and if friends already exist?

      @results['query1'].each do |f|

        friend = @current_user.friends.find_or_initialize_by_user_id_and_uid(:user_id => @current_user.id,:uid => f['uid'],:name => f['name'])

        cl = f['current_location']
        hl = f['hometown_location']


        if !cl.blank? and @locations.has_key?(cl['id'])
          current = Location.find_by_loc_id(cl['id'])

          if !current.blank?
            friend.current_location_id = current.id
          end
        end

        if !hl.blank? and @locations.has_key?(hl['id'])
          hometown = Location.find_by_loc_id(hl['id'])

          if !hometown.blank?
            friend.hometown_location_id = hometown.id
          end
        end


        if friend.valid?
          logger.debug("saving friend...")
          friend.save!
        end

      end

    end

  else
    redirect_to root_path
  end

  

end

end
