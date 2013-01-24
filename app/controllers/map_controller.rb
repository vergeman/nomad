class MapController < ApplicationController

def home

  if current_user

    @access_token  = @current_user.access_token
    begin
      @graph = Koala::Facebook::GraphAPI.new(@access_token)

      profile = @graph.get_object("me")
      friends = @graph.get_connections("me", "friends")
      puts profile
      puts friends.length

    rescue
      session[:user_id] = nil
      redirect_to root_path
    end

  else
    redirect_to root_path
  end

  

end

end
