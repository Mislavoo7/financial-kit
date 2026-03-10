# == Schema Information
#
# Table name: credits
#
#  id                     :bigint           not null, primary key
#  amount_in_cent         :integer          default(0)
#  calculation_method     :string           default("equal-installments")
#  interest_ratio         :decimal(5, 4)    default(0.0)
#  months_one             :integer          default(0)
#  number_of_installments :integer
#  repayment_year         :integer          default(0)
#  slug                   :string           default("")
#  start                  :integer          default(0)
#  start_at               :date
#  time_horizon           :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :integer
#
require "test_helper"

class CreditTest < ActiveSupport::TestCase
  def build_credit(attrs = {})
    Credit.new({
      amount_in_cent: 100_000,
      interest_ratio: 0.05,
      repayment_year: 5,
      months_one: 12,
      start: 1,
      start_at: Date.today,
      calculation_method: "equal-installments",
      slug: "credit-test-slug"
    }.merge(attrs))
  end

  test "is valid with valid attributes" do
    credit = build_credit
    assert credit.valid?
  end

  test "user association is optional" do
    credit = build_credit(user: nil)
    assert credit.valid?
  end

  test "is invalid without amount_in_cent" do
    credit = build_credit(amount_in_cent: nil)
    assert_not credit.valid?
    assert credit.errors[:amount_in_cent].any?
  end

  test "is invalid without interest_ratio" do
    credit = build_credit(interest_ratio: nil)
    assert_not credit.valid?
    assert credit.errors[:interest_ratio].any?
  end

  test "is invalid without repayment_year" do
    credit = build_credit(repayment_year: nil)
    assert_not credit.valid?
    assert credit.errors[:repayment_year].any?
  end

  test "is invalid without months_one" do
    credit = build_credit(months_one: nil)
    assert_not credit.valid?
    assert credit.errors[:months_one].any?
  end

  test "is invalid without start" do
    credit = build_credit(start: nil)
    assert_not credit.valid?
    assert credit.errors[:start].any?
  end

  test "is invalid without start_at" do
    credit = build_credit(start_at: nil)
    assert_not credit.valid?
    assert credit.errors[:start_at].any?
  end

  test "interest_ratio must be greater than or equal to 0" do
    credit = build_credit(interest_ratio: -0.01)
    assert_not credit.valid?
    assert credit.errors[:interest_ratio].any?
  end

  test "months_one must be greater than or equal to 0" do
    credit = build_credit(months_one: -1)
    assert_not credit.valid?
    assert credit.errors[:months_one].any?
  end

  test "amount_in_cent must be greater than 0" do
    credit = build_credit(amount_in_cent: 0)
    assert_not credit.valid?
    assert credit.errors[:amount_in_cent].any?
  end

  test "repayment_year must be greater than 0" do
    credit = build_credit(repayment_year: 0)
    assert_not credit.valid?
    assert credit.errors[:repayment_year].any?
  end

  test "start must be greater than 0" do
    credit = build_credit(start: 0)
    assert_not credit.valid?
    assert credit.errors[:start].any?
  end

  test "calculation_method must be included in allowed values" do
    credit = build_credit(calculation_method: "invalid-method")
    assert_not credit.valid?
    assert credit.errors[:calculation_method].any?
  end

  test "calculation_method must be present" do
    credit = build_credit(calculation_method: nil)
    assert_not credit.valid?
    assert credit.errors[:calculation_method].any?
  end

  test "ratio_fields returns interest_ratio" do
    credit = build_credit
    assert_equal [:interest_ratio], credit.ratio_fields
  end

  test "money_fields returns amount_in_cent" do
    credit = build_credit
    assert_equal [:amount_in_cent], credit.money_fields
  end

  test "humanize_interest_ratio returns percent string" do
    credit = build_credit(interest_ratio: 0.055)
    assert_equal "5.5%", credit.humanize_interest_ratio
  end

  test "humanize_amount_in_cent returns formatted euro amount" do
    credit = build_credit(amount_in_cent: 123_456)
    assert_equal "1.234,56 €", credit.humanize_amount_in_cent
  end

  test "to_param returns slug" do
    credit = build_credit(slug: "moj-kredit")
    assert_equal "moj-kredit", credit.to_param
  end
end
