# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  def build_user(email: "user#{SecureRandom.hex(4)}@example.com")
    User.new(
      email: email,
      password: "password123"
    )
  end

  test "is valid with valid attributes" do
    user = build_user
    assert user.valid?
  end

  test "has many credits" do
    association = User.reflect_on_association(:credits)
    assert_equal :has_many, association.macro
  end

  test "has many salary_calculators" do
    association = User.reflect_on_association(:salary_calculators)
    assert_equal :has_many, association.macro
  end

  test "has many author_fee_calculators" do
    association = User.reflect_on_association(:author_fee_calculators)
    assert_equal :has_many, association.macro
  end

  test "has many service_contract_calculators" do
    association = User.reflect_on_association(:service_contract_calculators)
    assert_equal :has_many, association.macro
  end

  test "destroying user destroys associated credits" do
    user = build_user(email: "credit_user@example.com")
    user.save!

    Credit.create!(
      user: user,
      amount_in_cent: 100_000,
      interest_ratio: 0.05,
      repayment_year: 5,
      months_one: 12,
      start: 1,
      start_at: Date.today,
      calculation_method: "equal-installments"
    )

    assert_difference("Credit.count", -1) do
      user.destroy
    end
  end

  test "destroying user destroys associated salary calculators" do
    user = build_user(email: "salary_user@example.com")
    user.save!

    SalaryCalculator.create!(
      user: user,
      amount_in_cent: 100_000,
      calculation_type: "brut-to-net",
      dependents_num: 0,
      disability: "no-disability",
      kids_num: 0,
      personal_deduction: 1,
      city_tax_rate_id: 1
    )

    assert_difference("SalaryCalculator.count", -1) do
      user.destroy
    end
  end

  test "destroying user destroys associated author fee calculators" do
    user = build_user(email: "author_user@example.com")
    user.save!

    AuthorFeeCalculator.create!(
      user: user,
      amount_in_cent: 100_000,
      calculation_type: "brut-to-net",
      fee_type: "contract",
      city_tax_rate_id: 1
    )

    assert_difference("AuthorFeeCalculator.count", -1) do
      user.destroy
    end
  end

  test "destroying user destroys associated service contract calculators" do
    user = build_user(email: "service_user@example.com")
    user.save!

    ServiceContractCalculator.create!(
      user: user,
      amount_in_cent: 100_000,
      calculation_type: "brut-to-net",
      city_tax_rate_id: 1
    )

    assert_difference("ServiceContractCalculator.count", -1) do
      user.destroy
    end
  end
end
