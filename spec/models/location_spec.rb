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

require 'spec_helper'

describe Location do
  pending "add some examples to (or delete) #{__FILE__}"
end
