# == Schema Information
#
# Table name: service_contract_calculators
#
#  id                       :bigint           not null, primary key
#  amount_in_cent           :integer          default(0)
#  brut_in_cent             :integer
#  calculation_type         :string           default("brut-to-net")
#  employer_to_pay_in_cent  :integer
#  first_pillar_in_cent     :integer
#  first_pillar_ratio       :decimal(5, 4)
#  health_insurance_in_cent :integer
#  health_insurance_ratio   :decimal(5, 4)
#  income_tax_in_cent       :integer
#  income_tax_ratio         :decimal(5, 4)
#  net_in_cent              :integer
#  second_pillar_in_cent    :integer
#  second_pillar_ratio      :decimal(5, 4)
#  slug                     :string
#  taxation_base_in_cent    :integer
#  total_pillar_in_cent     :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  city_tax_rate_id         :integer
#  user_id                  :integer
#
require "test_helper"

class ServiceContractCalculatorTest < ActiveSupport::TestCase
  def build_service_contract_calculator(attrs = {})
    ServiceContractCalculator.new({
      amount_in_cent: 100_000,
      calculation_type: "brut-to-net",
      city_tax_rate_id: 1,
      slug: "service-contract-test-slug",
      brut_in_cent: 150_000,
      net_in_cent: 110_000
    }.merge(attrs))
  end

  test "is valid with valid attributes" do
    calculator = build_service_contract_calculator
    assert calculator.valid?
  end

  test "user association is optional" do
    calculator = build_service_contract_calculator(user: nil)
    assert calculator.valid?
  end

  test "is invalid without amount_in_cent" do
    calculator = build_service_contract_calculator(amount_in_cent: nil)
    assert_not calculator.valid?
    assert calculator.errors[:amount_in_cent].any?
  end

  test "is invalid without calculation_type" do
    calculator = build_service_contract_calculator(calculation_type: nil)
    assert_not calculator.valid?
    assert calculator.errors[:calculation_type].any?
  end

  test "is invalid with wrong calculation_type" do
    calculator = build_service_contract_calculator(calculation_type: "something invalid")
    assert_not calculator.valid?
    assert calculator.errors[:calculation_type].any?
  end

  test "is invalid without city_tax_rate_id" do
    calculator = build_service_contract_calculator(city_tax_rate_id: nil)
    assert_not calculator.valid?
    assert calculator.errors[:city_tax_rate_id].any?
  end

  test "amount_in_cent must be greater than or equal to 0" do
    calculator = build_service_contract_calculator(amount_in_cent: -1)
    assert_not calculator.valid?
    assert calculator.errors[:amount_in_cent].any?
  end

  test "money_fields returns amount_in_cent" do
    calculator = build_service_contract_calculator
    assert_equal [:amount_in_cent], calculator.money_fields
  end

  test "humanize_amount_in_cent returns formatted euro amount" do
    calculator = build_service_contract_calculator(amount_in_cent: 123_456)
    assert_equal "1.234,56 €", calculator.humanize_amount_in_cent
  end

  test "humanize_brut_in_cent returns formatted euro amount" do
    calculator = build_service_contract_calculator(brut_in_cent: 234_567)
    assert_equal "2.345,67 €", calculator.humanize_brut_in_cent
  end

  test "humanize_net_in_cent returns formatted euro amount" do
    calculator = build_service_contract_calculator(net_in_cent: 98_765)
    assert_equal "987,65 €", calculator.humanize_net_in_cent
  end

  test "to_param returns slug" do
    calculator = build_service_contract_calculator(slug: "ugovor-o-djelu")
    assert_equal "ugovor-o-djelu", calculator.to_param
  end
end
