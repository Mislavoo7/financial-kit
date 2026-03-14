require "test_helper"

class User::SalaryCalculatorsControllerTest < ActionDispatch::IntegrationTest
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

    @other_user = User.create!(
      email: "other@example.com",
      password: "password123"
    )

    @city_tax_rate = CityTaxRate.create!(
      title: "Osijek",
      higher_rate: 30,
      lower_rate: 20
    )

    @salary_calculator = @user.salary_calculators.create!(
      valid_salary_calculator_params
    )

    @other_user_calculator = @other_user.salary_calculators.create!(
      valid_salary_calculator_params
    )

    sign_in @user
  end

  test "edit loads successfully for current user's calculator" do
    get edit_user_salary_calculator_path(id: @salary_calculator.slug)
    assert_response :success
  end

  test "update changes calculator for current user" do
    patch user_salary_calculator_path(id: @salary_calculator.slug), params: {
      salary_calculator: {
        amount_in_cent: 2000
      }
    }

    assert_redirected_to user_calculations_path
    assert_equal 200_000, @salary_calculator.reload.amount_in_cent
  end

  test "update does not change calculator with invalid params" do
    old_amount = @salary_calculator.amount_in_cent

    patch user_salary_calculator_path(id: @salary_calculator.slug), params: {
      salary_calculator: invalid_salary_calculator_params
    }

    assert_response :success
    assert_equal old_amount, @salary_calculator.reload.amount_in_cent
  end

  test "destroy removes current user's calculator" do
    assert_difference("SalaryCalculator.count", -1) do
      delete user_salary_calculator_path(id: @salary_calculator.slug), headers: {
        "HTTP_ACCEPT" => "text/javascript"
      }
    end

    assert_response :success
  end

  test "current user cannot edit another user's calculator" do
    get edit_user_salary_calculator_path(id: @other_user_calculator.slug)
    assert_response :not_found
  end

  test "current user cannot update another user's calculator" do
    patch user_salary_calculator_path(id: @other_user_calculator.slug), params: {
      salary_calculator: {
        amount_in_cent: 2000
      }
    }

    assert_response :not_found
    assert_not_equal 200_000, @other_user_calculator.reload.amount_in_cent
  end

  test "current user cannot destroy another user's calculator" do
    assert_no_difference("SalaryCalculator.count") do
      delete user_salary_calculator_path(id: @other_user_calculator.slug), headers: {
        "HTTP_ACCEPT" => "text/javascript"
      }
    end

    assert_response :not_found
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
