require "test_helper"

class User::ServiceContractCalculatorsControllerTest < ActionDispatch::IntegrationTest
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

    @service_contract_calculator = @user.service_contract_calculators.create!(
      valid_service_contract_calculator_params
    )

    @other_user_calculator = @other_user.service_contract_calculators.create!(
      valid_service_contract_calculator_params
    )

    sign_in @user
  end

  test "edit loads successfully for current user's calculator" do
    get edit_user_service_contract_calculator_path(id: @service_contract_calculator.slug)
    assert_response :success
  end

  test "update changes calculator for current user" do
    patch user_service_contract_calculator_path(id: @service_contract_calculator.slug), params: {
      service_contract_calculator: {
        amount_in_cent: 2000
      }
    }

    assert_redirected_to user_calculations_path
    assert_equal 200_000, @service_contract_calculator.reload.amount_in_cent
  end

  test "update does not change calculator with invalid params" do
    old_amount = @service_contract_calculator.amount_in_cent

    patch user_service_contract_calculator_path(id: @service_contract_calculator.slug), params: {
      service_contract_calculator: invalid_service_contract_calculator_params
    }

    assert_response :success
    assert_equal old_amount, @service_contract_calculator.reload.amount_in_cent
  end

  test "destroy removes current user's calculator" do
    assert_difference("ServiceContractCalculator.count", -1) do
      delete user_service_contract_calculator_path(id: @service_contract_calculator.slug), headers: {
        "HTTP_ACCEPT" => "text/javascript"
      }
    end

    assert_response :success
  end

  test "current user cannot edit another user's calculator" do
    get edit_user_service_contract_calculator_path(id: @other_user_calculator.slug)
    assert_response :not_found
  end

  test "current user cannot update another user's calculator" do
    patch user_service_contract_calculator_path(id: @other_user_calculator.slug), params: {
      service_contract_calculator: {
        amount_in_cent: 2000
      }
    }

    assert_response :not_found
    assert_not_equal 200_000, @other_user_calculator.reload.amount_in_cent
  end

  test "current user cannot destroy another user's calculator" do
    assert_no_difference("ServiceContractCalculator.count") do
      delete user_service_contract_calculator_path(id: @other_user_calculator.slug), headers: {
        "HTTP_ACCEPT" => "text/javascript"
      }
    end

    assert_response :not_found
  end

  private

  def valid_service_contract_calculator_params
    {
      amount_in_cent: 1_000_000,
      calculation_type: "brut-to-net",
      city_tax_rate_id: @city_tax_rate.id,
      brut_in_cent: 1_000_000,
      taxation_base_in_cent: 900000,
      employer_to_pay_in_cent: 1075000,
      first_pillar_ratio: 0.075,
      first_pillar_in_cent: 75000,
      second_pillar_ratio: 0.025,
      second_pillar_in_cent: 25000,
      total_pillar_in_cent: 100000,
      income_tax_ratio: 0.10,
      income_tax_in_cent: 900000,
      net_in_cent: 693000,
      health_insurance_ratio: 0.075,
      health_insurance_in_cent: 75000
    }
  end

  def invalid_service_contract_calculator_params
    {
      amount_in_cent: nil,
      calculation_type: nil,
      city_tax_rate_id: nil
    }
  end
end
