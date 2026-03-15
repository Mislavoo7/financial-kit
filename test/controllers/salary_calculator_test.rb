require "test_helper"

class SalaryCalculatorsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def create_about_page(position = nil)
    attrs = {
      name: "about",
      page_translations_attributes: [
        { title: "About Us", locale: "en" },
        { title: "Über uns", locale: "de" },
        { title: "O nama", locale: "hr" }
      ]
    }

    attrs[:position] = position unless position.nil?

    Page.create!(attrs)
  end

  def create_home_page(position = nil)
    attrs = {
      name: "home",
      page_translations_attributes: [
        { title: "Financial Kit", locale: "en" },
        { title: "Financial Kit", locale: "de" },
        { title: "Financial Kit", locale: "hr" }
      ]
    }

    attrs[:position] = position unless position.nil?

    Page.create!(attrs)
  end

  def setup
    @home_page = create_home_page
    @about_page = create_about_page
    @seo = @home_page.seo

    @user = User.create!(
      email: "test@example.com",
      password: "password123"
    )

    @city_tax_rate = CityTaxRate.create!(
      title: "Osijek",
      higher_rate: 30,
      lower_rate: 20,
    )
  end

  test "new loads successfully" do
    get new_salary_calculator_path
    assert_includes response.body, "<title>Financial "
    assert_response :success
  end

  test "create saves calculator and stores slug in cookie for guest" do
    assert_difference("SalaryCalculator.count", 1) do
      post salary_calculators_path, params: {
        salary_calculator: valid_salary_calculator_params
      }
    end

    calculator = SalaryCalculator.last

    assert_equal calculator.slug, cookies["salary_calculator_id"]
    assert_redirected_to user_calculations_path
  end

  test "create saves calculator and assigns it to current user" do
    sign_in @user

    assert_difference("SalaryCalculator.count", 1) do
      post salary_calculators_path, params: {
        salary_calculator: valid_salary_calculator_params
      }
    end

    calculator = SalaryCalculator.last

    assert_includes @user.salary_calculators.reload, calculator
    assert_nil cookies["salary_calculator_id"]
    assert_redirected_to user_calculations_path
  end

  test "create does not save invalid calculator" do
    assert_no_difference("SalaryCalculator.count") do
      post salary_calculators_path, params: {
        salary_calculator: invalid_salary_calculator_params
      }
    end

    assert_response :success
  end

  private

  def valid_salary_calculator_params
    {
      amount_in_cent: 130000,
      calculation_type: "brut-to-net",
      dependents_num: 0,
      disability: "no-disability",
      kids_num: 2,
      personal_deduction: 104000,
      city_tax_rate_id: @city_tax_rate.id,
      brut_in_cent: 130000,
      first_pillar_in_cent: 19500,
      second_pillar_in_cent: 6500,
      total_pillar_in_cent: 26000,
      taxation_base_in_cent: 0,
      pdv_one_in_cent: 0,
      pdv_two_in_cent: 0,
      income_tax_in_cent: 0,
      health_insurance_in_cent: 21450,
      employer_to_pay_in_cent: 151450,
      net_in_cent: 104000,
      first_pillar_ratio: 0.15,
      second_pillar_ratio: 0.05,
      total_pillar_ratio: 0.20,
      pdv_one_ratio: 0.0,
      pdv_two_ratio: 0.0,
      health_insurance_ratio: 0.165
    }
  end

  def invalid_salary_calculator_params
    {
      amount_in_cent: nil,
      calculation_type: nil,
      city_tax_rate_id: nil
    }
  end
end
