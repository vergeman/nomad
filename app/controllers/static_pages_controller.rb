require 'koala'

class StaticPagesController < ApplicationController
  before_filter :parse_facebook_cookies

  def home
    @access_token = @facebook_cookies["access_token"]
    puts "ACCESS_TOKEN: #{@access_token}"

    unless @access_token.nil?
      redirect_to map_path
    end

  end

  def about
  end

  def contact
  end

end
