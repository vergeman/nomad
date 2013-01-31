require 'delayed_job'

class MapController < ApplicationController


  def home

    if current_user

      #test valid (non-expired) koala fb cookie
      begin
        @graph = Koala::Facebook::API.new(@current_user.access_token)
        logger.debug("Connection OK: #{@graph.inspect}")
      rescue => error
        logger.debug("#{error}")
        expire_cookie_and_redirect
      end
        
      #fb likes our token, load friends etc in bg job
      flsj = FriendLocationSaveJob.new(@current_user)
      flsj.delay.run

    else
      redirect_to root_path
    end

  end


  private

  def expire_cookie_and_redirect
    session[:user_id] = nil
    flash[:notice] = "Cookies have expired"
    redirect_to root_path
  end

end
