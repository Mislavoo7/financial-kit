# == Schema Information
#
# Table name: salary_calculators
#
#  id                       :bigint           not null, primary key
#  amount_in_cent           :integer          default(0)
#  brut_in_cent             :integer          default(0), not null
#  calculation_type         :string           default("brut-to-net")
#  dependents_num           :integer          default(0)
#  disability               :string           default("no-disability")
#  employer_to_pay_in_cent  :integer          default(0), not null
#  first_pillar_in_cent     :integer          default(0), not null
#  first_pillar_ratio       :decimal(5, 4)    default(0.0), not null
#  health_insurance_in_cent :integer          default(0), not null
#  health_insurance_ratio   :decimal(5, 4)    default(0.0), not null
#  income_tax_in_cent       :integer          default(0), not null
#  kids_num                 :integer          default(0)
#  net_in_cent              :integer          default(0), not null
#  pdv_one_in_cent          :integer          default(0), not null
#  pdv_one_ratio            :decimal(5, 4)    default(0.0), not null
#  pdv_two_in_cent          :integer          default(0), not null
#  pdv_two_ratio            :decimal(5, 4)    default(0.0), not null
#  personal_deduction       :integer          default(1)
#  second_pillar_in_cent    :integer          default(0), not null
#  second_pillar_ratio      :decimal(5, 4)    default(0.0), not null
#  slug                     :string           default("")
#  taxation_base_in_cent    :integer          default(0), not null
#  total_pillar_in_cent     :integer          default(0), not null
#  total_pillar_ratio       :decimal(5, 4)    default(0.0), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  city_tax_rate_id         :integer
#  user_id                  :integer
#
require "test_helper"

class SalaryCalculatorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
