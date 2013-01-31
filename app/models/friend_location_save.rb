class FriendLocationSave
  attr_accessor :results, :locations

  #== Query data, setup, parse, and save ==
  def initialize(current_user)

    #==query
    q = Query.new(current_user.access_token)

    @results = q.query_friends_and_locations

    if @results.has_key?(:error)
      Rails.logger.debug("ERROR: #{p @results}")
      return nil
    end

    #==Building data structures
    @locations = Hash.new()

    build_and_save_locations

    build_and_save_friends(current_user)

    return true
  end




  def parse_location_result(query_name)
    #===unroll queries====
    
    @results[query_name].each do |l|
      @locations[l['page_id']] = {
        :name => !l['name'].nil? ? l['name'] : '',
        :latitude => !l['location'].empty?  ? l['location']['latitude'] : '',
        :longitude => !l['location'].empty? ? l['location']['longitude'] : ''
      }
    end

  end


  def save_locations
    @locations.each do |k, v|      
      place = Location.find_or_initialize_by_loc_id(:loc_id => k, :name => v[:name], :lat => v[:latitude], :long => v[:longitude])

      if place.valid?
        Rails.logger.debug( "saving place...")
        place.save!
      end

    end
  end


  def build_and_save_locations
    Rails.logger.debug("build_and_save_locations")

    parse_location_result('query3')

    parse_location_result('query2')    
    
    save_locations
  end




  #f: a friend (of the user)
  #friend: initialized active record of friend (db)
  #attribute - current_location/ hometown_location

  def check_and_save_location_data(f, friend, attribute)
    Rails.logger.debug("check_and_save_location_data, #{attribute}")

    loc = f[attribute] #current_location

    if !loc.blank? and @locations.has_key?(loc['id'])

      loc_record = Location.find_by_loc_id(loc['id'])

      if !loc_record.blank? and !loc_record.id.blank?
        friend.send("#{attribute}_id=", loc_record.id)
      end
    end

  end


  def build_and_save_friends(current_user)
    Rails.logger.debug("build_and_save_friends")
    #===Friends Datastore===

    # and if friends already exist?

    @results['query1'].each do |f|

      friend = current_user.friends.find_or_initialize_by_user_id_and_uid(:user_id => current_user.id,:uid => f['uid'],:name => f['name'])

      #CHECK
      check_and_save_location_data(f, friend, 'current_location')

      check_and_save_location_data(f, friend, 'hometown_location')

      if friend.valid?
        Rails.logger.debug("saving friend...")
        friend.save!
      end

    end

  end



end
