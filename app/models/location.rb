# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  loc_id     :integer
#  name       :string(255)
#  city       :string(255)
#  state      :string(255)
#  country    :string(255)
#  zipcode    :integer
#  lat        :decimal(, )
#  long       :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'httpclient'
require 'json'
class Location < ActiveRecord::Base

  attr_accessible :city, :country, :lat, :loc_id, :long, :name, :state, :zipcode
  has_many :friends

  validates :loc_id, uniqueness: true

  def get_geo(city, state, country)
    client = HTTPClient.new()
    puts "#{city}, #{state}"

    url =  URI.encode("http://query.yahooapis.com/v1/public/yql?q=select centroid from geo.places where text = \"#{city}, #{state}\" LIMIT 1&format=json")


    result = client.get url

    JSON.parse(result.content)
  end
end
