class ApplicationController < ActionController::Base
  protect_from_forgery

   def parse_facebook_cookies
     begin
       puts "PARSING"
       @facebook_cookies ||= Koala::Facebook::OAuth.new(ENV['FB_ID'], ENV['FB_SECRET']).get_user_info_from_cookie(cookies)
       puts @facebook_cookies
     rescue =>e
       puts e
       puts "COOKIE: #{@facebook_cookies}"
       @facebook_cookies = Hash.new
     end

     return true
  end


end
