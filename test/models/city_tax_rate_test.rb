# == Schema Information
#
# Table name: city_tax_rates
#
#  id          :bigint           not null, primary key
#  higher_rate :decimal(5, 4)
#  lower_rate  :decimal(5, 4)
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class CityTaxRateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
