require "test_helper"

class CalculationMethodsTest < ActiveSupport::TestCase
  def setup
    @calc = Object.new
    @calc.extend CalculationMethods
  end

  test "cents_to_euro converts cents to euro" do
    assert_equal 100, @calc.cents_to_euro(10_000)
  end

  test "cents_to_euro converts small amount" do
    assert_equal 1.23, @calc.cents_to_euro(123)
  end

  test "cents_to_euro returns empty string for nil" do
    assert_equal "", @calc.cents_to_euro(nil)
  end

  test "euro_to_cent converts euro to cents" do
    assert_equal 10_000, @calc.euro_to_cent(100)
  end

  test "euro_to_cent converts decimal euro to cents" do
    assert_equal 1234, @calc.euro_to_cent(12.34)
  end

  test "humanize_euro formats integer euro" do
    assert_equal "100,00 €", @calc.humanize_euro(100)
  end

  test "humanize_euro formats thousands" do
    assert_equal "1.234,50 €", @calc.humanize_euro(1234.5)
  end

  test "ratio_to_percent converts ratio to percent" do
    assert_equal "25%", @calc.ratio_to_percent(0.25)
  end

  test "ratio_to_percent handles decimals" do
    assert_equal "12.5%", @calc.ratio_to_percent(0.125)
  end

  test "ratio_to_percent returns empty string for nil" do
    assert_equal "", @calc.ratio_to_percent(nil)
  end

  test "normalize_ratio converts percent string" do
    assert_equal BigDecimal("0.25"), @calc.normalize_ratio("25")
  end

  test "normalize_ratio converts percent with comma" do
    assert_equal BigDecimal("0.125"), @calc.normalize_ratio("12,5%")
  end

  test "normalize_ratio keeps decimal ratio" do
    assert_equal BigDecimal("0.25"), @calc.normalize_ratio("0.25")
  end

  test "normalize_ratio returns nil for blank" do
    assert_nil @calc.normalize_ratio("")
  end
end
