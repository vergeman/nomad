require 'koala'


class MapController < ApplicationController
  before_filter :parse_facebook_cookies

def home  
  puts "MAP HERE"
  @access_token = @facebook_cookies["access_token"]
  puts "MAP ACCESS_TOKEN: #{@access_token}"

  unless @access_token.nil?
    puts "MAP HAS ACCESS TOKEN"
    @graph = Koala::Facebook::GraphAPI.new(@access_token)

    profile = @graph.get_object("me")
    friends = @graph.get_connections("me", "friends")

    puts @graph
    puts profile
    puts friends
  else
    redirect_to root_path
  end

  

end

end
