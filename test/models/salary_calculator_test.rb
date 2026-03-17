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
  def build_salary_calculator(attrs = {})
    SalaryCalculator.new({
      amount_in_cent: 100_000,
      calculation_type: "brut-to-net",
      dependents_num: 0,
      disability: "no-disability",
      kids_num: 0,
      personal_deduction: 1,
      city_tax_rate_id: 1,
      slug: "salary-test-slug",
      brut_in_cent: 150_000,
      net_in_cent: 110_000
    }.merge(attrs))
  end

  test "is valid with valid attributes" do
    salary_calculator = build_salary_calculator
    assert salary_calculator.valid?
  end

  test "user association is optional" do
    salary_calculator = build_salary_calculator(user: nil)
    assert salary_calculator.valid?
  end

  test "is invalid without amount_in_cent" do
    salary_calculator = build_salary_calculator(amount_in_cent: nil)
    assert_not salary_calculator.valid?
    assert salary_calculator.errors[:amount_in_cent].any?
  end

  test "is invalid without calculation_type" do
    salary_calculator = build_salary_calculator(calculation_type: nil)
    assert_not salary_calculator.valid?
    assert salary_calculator.errors[:calculation_type].any?
  end

  test "is invalid with wrong calculation_type" do
    salary_calculator = build_salary_calculator(calculation_type: "something-invalid")
    assert_not salary_calculator.valid?
    assert salary_calculator.errors[:calculation_type].any?
  end

  test "is invalid without dependents_num" do
    salary_calculator = build_salary_calculator(dependents_num: nil)
    assert_not salary_calculator.valid?
    assert salary_calculator.errors[:dependents_num].any?
  end

  test "is invalid without disability" do
    salary_calculator = build_salary_calculator(disability: nil)
    assert_not salary_calculator.valid?
    assert salary_calculator.errors[:disability].any?
  end

  test "is invalid without kids_num" do
    salary_calculator = build_salary_calculator(kids_num: nil)
    assert_not salary_calculator.valid?
    assert salary_calculator.errors[:kids_num].any?
  end

  test "is invalid without personal_deduction" do
    salary_calculator = build_salary_calculator(personal_deduction: nil)
    assert_not salary_calculator.valid?
    assert salary_calculator.errors[:personal_deduction].any?
  end

  test "is invalid without city_tax_rate_id" do
    salary_calculator = build_salary_calculator(city_tax_rate_id: nil)
    assert_not salary_calculator.valid?
    assert salary_calculator.errors[:city_tax_rate_id].any?
  end

  test "amount_in_cent must be greater than or equal to 0" do
    salary_calculator = build_salary_calculator(amount_in_cent: -1)
    assert_not salary_calculator.valid?
    assert salary_calculator.errors[:amount_in_cent].any?
  end

  test "dependents_num must be greater than or equal to 0" do
    salary_calculator = build_salary_calculator(dependents_num: -1)
    assert_not salary_calculator.valid?
    assert salary_calculator.errors[:dependents_num].any?
  end

  test "kids_num must be greater than or equal to 0" do
    salary_calculator = build_salary_calculator(kids_num: -1)
    assert_not salary_calculator.valid?
    assert salary_calculator.errors[:kids_num].any?
  end

  test "personal_deduction must be greater than or equal to 1" do
    salary_calculator = build_salary_calculator(personal_deduction: 0)
    assert_not salary_calculator.valid?
    assert salary_calculator.errors[:personal_deduction].any?
  end

  test "disability must be included in disability types" do
    salary_calculator = build_salary_calculator(disability: "somethingelse")
    assert_not salary_calculator.valid?
    assert salary_calculator.errors[:disability].any?
  end

  test "money_fields returns amount_in_cent" do
    salary_calculator = build_salary_calculator
    assert_equal [ :amount_in_cent ], salary_calculator.money_fields
  end

  test "humanize_amount_in_cent returns formatted euro amount" do
    salary_calculator = build_salary_calculator(amount_in_cent: 123_456)
    assert_equal "1.234,56 €", salary_calculator.humanize_amount_in_cent
  end

  test "humanize_brut_in_cent returns formatted euro amount" do
    salary_calculator = build_salary_calculator(brut_in_cent: 234_567)
    assert_equal "2.345,67 €", salary_calculator.humanize_brut_in_cent
  end

  test "humanize_net_in_cent returns formatted euro amount" do
    salary_calculator = build_salary_calculator(net_in_cent: 98_765)
    assert_equal "987,65 €", salary_calculator.humanize_net_in_cent
  end

  test "to_param returns slug" do
    salary_calculator = build_salary_calculator(slug: "moja-plata")
    assert_equal "moja-plata", salary_calculator.to_param
  end
end
