# == Schema Information
#
# Table name: friends
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  name                 :string(255)
#  current_location_id  :integer
#  hometown_location_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  uid                  :integer
#

class Friend < ActiveRecord::Base
  attr_accessible :current_location_id, :hometown_location_id, :name, :user_id, :uid

  belongs_to :user
  belongs_to :current_location, :class_name => 'Location', :foreign_key => 'current_location_id'
  belongs_to :hometown_location, :class_name => 'Location', :foreign_key => 'hometown_location_id'

#  we'll keep this simple for now, handle enforcing
#  mutual friends later
#  validates :uid, uniqueness: true
end
