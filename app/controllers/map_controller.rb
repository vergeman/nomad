class MapController < ApplicationController

def home

  if current_user

    @access_token  = @current_user.access_token
    begin
      @graph = Koala::Facebook::GraphAPI.new(@access_token)

      @profile = @graph.get_object("me")
      # @friends = @graph.get_connections("me", "friends")

      @friends = @graph.fql_query("SELECT uid, name, current_location, hometown_location FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE  uid1 = me())")



    rescue => error
      puts error
      session[:user_id] = nil
      redirect_to root_path
    end

  else
    redirect_to root_path
  end

  

end

end
