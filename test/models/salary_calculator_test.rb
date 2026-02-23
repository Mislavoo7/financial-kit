# == Schema Information
#
# Table name: salary_calculators
#
#  id                 :bigint           not null, primary key
#  amount_in_cent     :integer          default(0)
#  calculation_type   :string           default("brut-to-net")
#  dependents_num     :integer          default(0)
#  disability         :string           default("no-disability")
#  kids_num           :integer          default(0)
#  personal_deduction :integer          default(1)
#  slug               :string           default("")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  city_tax_rate_id   :integer
#  user_id            :integer
#
require "test_helper"

class SalaryCalculatorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
