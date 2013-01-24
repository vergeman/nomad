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

require 'spec_helper'

describe Friend do
  pending "add some examples to (or delete) #{__FILE__}"
end
