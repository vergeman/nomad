require 'koala'
require 'json'

class Query
  attr_accessor :graph, :results
  
  def initialize(access_token)
    @graph = Koala::Facebook::API.new(access_token)
  end


  def query_friends_and_locations
    Rails.logger.debug("Query::query_friends_and_locations")
    begin

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
      return {:error => error}

    else
      return @results
    end

  end

end
