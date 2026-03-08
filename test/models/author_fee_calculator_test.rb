# == Schema Information
#
# Table name: author_fee_calculators
#
#  id                          :bigint           not null, primary key
#  amount_in_cent              :integer          default(0)
#  brut_in_cent                :integer          default(0), not null
#  calculation_type            :string           default("brut-to-net")
#  contribution_base_in_cent   :integer          default(0), not null
#  employer_to_pay_in_cent     :integer          default(0), not null
#  fee_type                    :string           default("contract")
#  first_pillar_in_cent        :integer          default(0), not null
#  first_pillar_ratio          :decimal(5, 4)    default(0.0), not null
#  health_insurance_in_cent    :integer          default(0), not null
#  health_insurance_ratio      :decimal(5, 4)    default(0.0), not null
#  income_in_cent              :integer          default(0), not null
#  income_tax_in_cent          :integer          default(0), not null
#  income_tax_ratio            :decimal(5, 4)    default(0.0), not null
#  lump_sum_additional_in_cent :integer          default(0), not null
#  lump_sum_additional_ratio   :decimal(5, 4)    default(0.0), not null
#  lump_sum_in_cent            :integer          default(0), not null
#  lump_sum_ratio              :decimal(5, 4)    default(0.0), not null
#  net_in_cent                 :integer          default(0), not null
#  second_pillar_in_cent       :integer          default(0), not null
#  second_pillar_ratio         :decimal(5, 4)    default(0.0), not null
#  slug                        :string
#  taxation_base_in_cent       :integer          default(0), not null
#  total_pillar_in_cent        :integer          default(0), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  city_tax_rate_id            :integer
#  user_id                     :integer
#
require "test_helper"

class AuthorFeeCalculatorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
