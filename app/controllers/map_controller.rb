class MapController < ApplicationController

  def home

    @graph = nil

    if current_user

      #bg job here
      res = FriendLocationSave.new(@current_user)

      if res == nil
        session[:user_id] = nil
        # add flash for logout timeout here
        redirect_to root_path
      end

    else
      redirect_to root_path
    end

    

  end

end
