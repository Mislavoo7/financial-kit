require "test_helper"

class ServiceContractCalculatorsControllerTest < ActionDispatch::IntegrationTest
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
    @seo = Seo.create!(
      seoable: nil,
      seo_translations_attributes: {
        "0" => {
          title: "C SEO Title",
          url: "/credits/new",
          description: "service contract description",
          keywords: "service contract, calculator",
          locale: "hr"
        }
      }
    )


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

  test "SEO for service contract calculator" do
    get new_credit_path

    assert_response :success
    assert_includes response.body, "service contract SEO Title"
    assert_includes response.body, "service contract description"
  end

  test "create saves calculator and stores slug in cookie for guest" do
    assert_difference("ServiceContractCalculator.count", 1) do
      post service_contract_calculators_path, params: {
        service_contract_calculator: valid_service_contract_calculator_params
      }
    end

    calculator = ServiceContractCalculator.last

    assert_equal calculator.slug, cookies["service_contract_calculator_id"]
    assert_redirected_to user_calculations_path
  end

  test "create saves calculator and assigns it to current user" do
    sign_in @user

    assert_difference("ServiceContractCalculator.count", 1) do
      post service_contract_calculators_path, params: {
        service_contract_calculator: valid_service_contract_calculator_params
      }
    end

    calculator = ServiceContractCalculator.last

    assert_includes @user.service_contract_calculators.reload, calculator
    assert_nil cookies["service_contract_calculator_id"]
    assert_redirected_to user_calculations_path
  end

  test "create does not save invalid calculator" do
    assert_no_difference("ServiceContractCalculator.count") do
      post service_contract_calculators_path, params: {
        service_contract_calculator: invalid_service_contract_calculator_params
      }
    end

    assert_response :success
  end

  private

  def valid_service_contract_calculator_params
    {
      amount_in_cent: 1000000,
      calculation_type: "brut-to-net",
      city_tax_rate_id: @city_tax_rate.id,
      brut_in_cent: 1000000,
      first_pillar_in_cent: 75000,
      second_pillar_in_cent: 25000,
      total_pillar_in_cent: 100000,
      taxation_base_in_cent: 9000,
      income_tax_in_cent: 180000,
      health_insurance_in_cent: 75000,
      employer_to_pay_in_cent: 1075000,
      net_in_cent: 720000,
      income_tax_ratio: 0.20,
      first_pillar_ratio: 0.075,
      second_pillar_ratio: 0.025,
      health_insurance_ratio: 0.075
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
