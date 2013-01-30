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

require 'koala'
class Location < ActiveRecord::Base

  attr_accessible :city, :country, :lat, :loc_id, :long, :name, :state, :zipcode
  has_many :friends

  validates :loc_id, uniqueness: true
  validates :loc_id, :name, :lat, :long, :presence => true

#probably move this to a delayed job somewhere

end
