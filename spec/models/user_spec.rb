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

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
