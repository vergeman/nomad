class MapController < ApplicationController

def home

  if current_user

    @access_token  = @current_user.access_token

    begin
      @graph = Koala::Facebook::GraphAPI.new(@access_token)

      @profile = @graph.get_object("me")

      @friends = @graph.fql_query("SELECT uid, name, current_location, hometown_location FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE  uid1 = me())")
    rescue => error
      puts error
      session[:user_id] = nil
      redirect_to root_path
    end

      #===Friends Datastore===

      # and if friends already exist?
      @friends.each do |f|

        friend = @current_user.friends.find_or_initialize_by_user_id_and_uid(:uid => f['uid'], :name => f['name'])

        cl = f['current_location']
        hl = f['hometown_location']

        # Current Location friends

        if !cl.nil?
          loc = Location.find_or_create_by_loc_id(:loc_id => cl['id'], :name => cl['name'], :city => cl['city'], :state => cl['state'], :country => cl['country'], :zipcode => cl['zip'])

          friend.current_location = loc

          puts "HTTP: "
          puts loc.get_geo(cl['city'], cl['state'], cl['country'])
        end

        # Hometown location friends

        if !hl.nil?
          loc = Location.find_or_create_by_loc_id(:loc_id => hl['id'], :name => hl['name'], :city => hl['city'], :state => hl['state'], :country => hl['country'], :zipcode => hl['zip'])

          friend.hometown_location = loc
        end



        # f = Friend.find_or_create_by_user_id(friend)

        friend.save!
      end


  else
    redirect_to root_path
  end

  

end

end
