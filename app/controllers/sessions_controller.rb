require 'koala'
class SessionsController < ApplicationController
  def create

    begin
      @facebook_cookies ||= Koala::Facebook::OAuth.new(ENV['FB_ID'], ENV['FB_SECRET']).get_user_info_from_cookie(cookies)
      
      @user = User.find_or_initialize_by_uid(@facebook_cookies["user_id"]).tap do |user|
        user.new.blank? ? user.new = true : user.new = false
        user.uid = @facebook_cookies["user_id"]
        user.access_token = @facebook_cookies["access_token"]
        user.save!
      end

      session[:user_id] = @user.id

    rescue => e
      logger.error(e)
      redirect_to root_path
    end

    redirect_to map_path
  end
end
