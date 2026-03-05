# == Schema Information
#
# Table name: service_contract_calculators
#
#  id               :bigint           not null, primary key
#  amount_in_cent   :integer          default(0)
#  calculation_type :string           default("brut-to-net")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  city_tax_rate_id :integer
#  user_id          :integer
#
require "test_helper"

class ServiceContractCalculatorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
