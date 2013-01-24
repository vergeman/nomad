# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  uid          :integer
#  access_token :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :access_token, :uid
  has_many :friends

  validates :uid, uniqueness: true
end
