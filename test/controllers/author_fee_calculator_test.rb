require "test_helper"

class AuthorFeeCalculatorsControllerTest < ActionDispatch::IntegrationTest
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
          title: "AF SEO Title",
          url: "/author-fee-calculators/new",
          description: "AF description",
          keywords: "af, calculator",
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
      lower_rate: 20
    )
  end

  test "SEO for author fee calculator" do
    get new_author_fee_calculator_path

    assert_response :success
    assert_includes response.body, "AF SEO Title"
    assert_includes response.body, "AF description"
  end

  test "create saves calculator and stores slug in cookie for guest" do
    assert_difference("AuthorFeeCalculator.count", 1) do
      post author_fee_calculators_path, params: {
        author_fee_calculator: valid_author_fee_calculator_params
      }
    end

    calculator = AuthorFeeCalculator.last

    assert_equal calculator.slug, cookies["author_fee_calculator_id"]
    assert_redirected_to user_calculations_path
  end

  test "create saves calculator and assigns it to current user" do
    sign_in @user

    assert_difference("AuthorFeeCalculator.count", 1) do
      post author_fee_calculators_path, params: {
        author_fee_calculator: valid_author_fee_calculator_params
      }
    end

    calculator = AuthorFeeCalculator.last

    assert_includes @user.author_fee_calculators.reload, calculator
    assert_nil cookies["author_fee_calculator_id"]
    assert_redirected_to user_calculations_path
  end

  test "create does not save invalid calculator" do
    assert_no_difference("AuthorFeeCalculator.count") do
      post author_fee_calculators_path, params: {
        author_fee_calculator: invalid_author_fee_calculator_params
      }
    end

    assert_response :success
  end

  private

  def valid_author_fee_calculator_params
    {
      amount_in_cent: 1000000,
      calculation_type: "brut-to-net",
      fee_type: "artist-contract",
      city_tax_rate_id: @city_tax_rate.id,
      brut_in_cent: 1000000,
      contribution_base_in_cent: 450000,
      net_in_cent: 874000,
      lump_sum_ratio: 0.30,
      lump_sum_in_cent: 300000,
      lump_sum_additional_ratio: 0.25,
      lump_sum_additional_in_cent: 250000,
      first_pillar_ratio: 0.075,
      first_pillar_in_cent: 33750,
      second_pillar_ratio: 0.025,
      second_pillar_in_cent: 11250,
      total_pillar_in_cent: 45000,
      income_tax_ratio: 0.10,
      income_tax_in_cent: 81000,
      taxation_base_in_cent: 405000,
      income_in_cent: 405000,
      health_insurance_ratio: 0.075,
      health_insurance_in_cent: 33750,
      employer_to_pay_in_cent: 1033750
    }
  end

  def invalid_author_fee_calculator_params
    {
      amount_in_cent: nil,
      calculation_type: nil,
      fee_type: nil,
      city_tax_rate_id: nil
    }
  end
end
