require "test_helper"

class User::AuthorFeeCalculatorsControllerTest < ActionDispatch::IntegrationTest
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

    @author_fee_calculator = @user.author_fee_calculators.create!(
      valid_author_fee_calculator_params
    )

    @other_user_calculator = @other_user.author_fee_calculators.create!(
      valid_author_fee_calculator_params
    )

    sign_in @user
  end

  test "edit loads successfully for current user's calculator" do
    get edit_user_author_fee_calculator_path(id: @author_fee_calculator.slug)
    assert_response :success
  end

  test "update changes calculator for current user" do
    patch user_author_fee_calculator_path(id: @author_fee_calculator.slug), params: {
      author_fee_calculator: {
        amount_in_cent: 2000
      }
    }

    assert_redirected_to user_calculations_path
    assert_equal 200_000, @author_fee_calculator.reload.amount_in_cent
  end

  test "update does not change calculator with invalid params" do
    old_amount = @author_fee_calculator.amount_in_cent

    patch user_author_fee_calculator_path(id: @author_fee_calculator.slug), params: {
      author_fee_calculator: invalid_author_fee_calculator_params
    }

    assert_response :success
    assert_equal old_amount, @author_fee_calculator.reload.amount_in_cent
  end

  test "destroy removes current user's calculator" do
    assert_difference("AuthorFeeCalculator.count", -1) do
      delete user_author_fee_calculator_path(id: @author_fee_calculator.slug), headers: {
        "HTTP_ACCEPT" => "text/javascript"
      }
    end

    assert_response :success
  end

  test "current user cannot edit another user's calculator" do
    get edit_user_author_fee_calculator_path(id: @other_user_calculator.slug)
    assert_response :not_found
  end

  test "current user cannot update another user's calculator" do
    patch user_author_fee_calculator_path(id: @other_user_calculator.slug), params: {
      author_fee_calculator: {
        amount_in_cent: 2000
      }
    }

    assert_response :not_found
    assert_not_equal 200_000, @other_user_calculator.reload.amount_in_cent
  end

  test "current user cannot destroy another user's calculator" do
    assert_no_difference("AuthorFeeCalculator.count") do
      delete user_author_fee_calculator_path(id: @other_user_calculator.slug), headers: {
        "HTTP_ACCEPT" => "text/javascript"
      }
    end

    assert_response :not_found
  end

  private

  def valid_author_fee_calculator_params
    {
      amount_in_cent: 1_000_000,
      calculation_type: "brut-to-net",
      fee_type: "artist-contract",
      city_tax_rate_id: @city_tax_rate.id,
      brut_in_cent: 1_000_000,
      contribution_base_in_cent: 450_000,
      net_in_cent: 874_000,
      lump_sum_ratio: 0.30,
      lump_sum_in_cent: 300_000,
      lump_sum_additional_ratio: 0.25,
      lump_sum_additional_in_cent: 250_000,
      first_pillar_ratio: 0.075,
      first_pillar_in_cent: 33_750,
      second_pillar_ratio: 0.025,
      second_pillar_in_cent: 11_250,
      total_pillar_in_cent: 45_000,
      income_tax_ratio: 0.10,
      income_tax_in_cent: 81_000,
      taxation_base_in_cent: 405_000,
      income_in_cent: 405_000,
      health_insurance_ratio: 0.075,
      health_insurance_in_cent: 33_750,
      employer_to_pay_in_cent: 1_033_750
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
