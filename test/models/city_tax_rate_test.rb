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
  def build_city_tax_rate(attrs = {})
    CityTaxRate.new({
      title: "Osijek",
      higher_rate: 0.30,
      lower_rate: 0.20
    }.merge(attrs))
  end

  test "is valid with valid attributes" do
    city_tax_rate = build_city_tax_rate
    assert city_tax_rate.valid?
  end

  test "is invalid without title" do
    city_tax_rate = build_city_tax_rate(title: nil)

    assert city_tax_rate.invalid?
    assert city_tax_rate.errors.added?(:title, :blank)
  end

  test "is invalid without higher_rate" do
    city_tax_rate = build_city_tax_rate(higher_rate: nil)

    assert city_tax_rate.invalid?
    assert city_tax_rate.errors.added?(:higher_rate, :blank)
  end

  test "is invalid without lower_rate" do
    city_tax_rate = build_city_tax_rate(lower_rate: nil)

    assert city_tax_rate.invalid?
    assert city_tax_rate.errors.added?(:lower_rate, :blank)
  end

  test "higher_rate must be greater than 0" do
    [ 0, -0.01 ].each do |value|
      city_tax_rate = build_city_tax_rate(higher_rate: value)

      assert city_tax_rate.invalid?
      assert city_tax_rate.errors[:higher_rate].any?
    end
  end

  test "lower_rate must be greater than 0" do
    [ 0, -0.01 ].each do |value|
      city_tax_rate = build_city_tax_rate(higher_rate: value)

      assert city_tax_rate.invalid?
      assert city_tax_rate.errors[:higher_rate].any?
    end
  end

  test "humanize_higher_rate returns formatted percent" do
    city_tax_rate = build_city_tax_rate(higher_rate: 0.30)

    assert_equal "30%", city_tax_rate.humanize_higher_rate
  end

  test "humanize_lower_rate returns formatted percent" do
    city_tax_rate = build_city_tax_rate(lower_rate: 0.20)

    assert_equal "20%", city_tax_rate.humanize_lower_rate
  end

  test "default scope orders by title ascending" do
    zadar = CityTaxRate.create!(title: "Zadar", higher_rate: 0.30, lower_rate: 0.20)
    osijek = CityTaxRate.create!(title: "Osijek", higher_rate: 0.30, lower_rate: 0.20)
    zagreb = CityTaxRate.create!(title: "Zagreb", higher_rate: 0.30, lower_rate: 0.20)

    assert_equal [ osijek, zadar, zagreb ], CityTaxRate.all.to_a
  end

  test "lower_rate must be less than higher_rate" do
    [ 0.30, 0.35 ].each do |value|
      city_tax_rate = build_city_tax_rate(
        higher_rate: 0.30,
        lower_rate: value
      )

      assert city_tax_rate.invalid?
      assert city_tax_rate.errors[:lower_rate].any?
    end
  end
end
