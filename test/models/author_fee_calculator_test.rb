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
  def build_author_fee_calculator(attrs = {})
    AuthorFeeCalculator.new({
      amount_in_cent: 100_000,
      calculation_type: "brut-to-net",
      fee_type: "contract",
      city_tax_rate_id: 1,
      slug: "author-fee-test-slug",
      brut_in_cent: 150_000,
      net_in_cent: 110_000
    }.merge(attrs))
  end

  test "is valid with valid attributes" do
    calculator = build_author_fee_calculator
    assert calculator.valid?
  end

  test "user association is optional" do
    calculator = build_author_fee_calculator(user: nil)
    assert calculator.valid?
  end

  test "is invalid without amount_in_cent" do
    calculator = build_author_fee_calculator(amount_in_cent: nil)
    assert_not calculator.valid?
    assert calculator.errors[:amount_in_cent].any?
  end

  test "is invalid without calculation_type" do
    calculator = build_author_fee_calculator(calculation_type: nil)
    assert_not calculator.valid?
    assert calculator.errors[:calculation_type].any?
  end

  test "is invalid with other calculation_type" do
    calculator = build_author_fee_calculator(calculation_type: "something-to-something")
    assert_not calculator.valid?
    assert calculator.errors[:calculation_type].any?
  end

  test "is invalid without fee_type" do
    calculator = build_author_fee_calculator(fee_type: nil)
    assert_not calculator.valid?
    assert calculator.errors[:fee_type].any?
  end

  test "fee_type must be included in allowed values" do
    calculator = build_author_fee_calculator(fee_type: "invalid")
    assert_not calculator.valid?
    assert calculator.errors[:fee_type].any?
  end

  test "is invalid without city_tax_rate_id" do
    calculator = build_author_fee_calculator(city_tax_rate_id: nil)
    assert_not calculator.valid?
    assert calculator.errors[:city_tax_rate_id].any?
  end

  test "amount_in_cent must be greater than or equal to 0" do
    calculator = build_author_fee_calculator(amount_in_cent: -1)
    assert_not calculator.valid?
    assert calculator.errors[:amount_in_cent].any?
  end

  test "money_fields returns amount_in_cent" do
    calculator = build_author_fee_calculator
    assert_equal [ :amount_in_cent ], calculator.money_fields
  end

  test "humanize_amount_in_cent returns formatted euro amount" do
    calculator = build_author_fee_calculator(amount_in_cent: 123_456)
    assert_equal "1.234,56 €", calculator.humanize_amount_in_cent
  end

  test "humanize_brut_in_cent returns formatted euro amount" do
    calculator = build_author_fee_calculator(brut_in_cent: 234_567)
    assert_equal "2.345,67 €", calculator.humanize_brut_in_cent
  end

  test "humanize_net_in_cent returns formatted euro amount" do
    calculator = build_author_fee_calculator(net_in_cent: 98_765)
    assert_equal "987,65 €", calculator.humanize_net_in_cent
  end

  test "to_param returns slug" do
    calculator = build_author_fee_calculator(slug: "autorski-obracun")
    assert_equal "autorski-obracun", calculator.to_param
  end
end
