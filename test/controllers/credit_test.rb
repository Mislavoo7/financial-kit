require "test_helper"

class CreditsControllerTest < ActionDispatch::IntegrationTest
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
          description: "C description",
          keywords: "C, calculator",
          locale: "hr"
        }
      }
    )

    @user = User.create!(
      email: "test@example.com",
      password: "password123"
    )
  end

  test "SEO for credit calculator" do
    get new_credit_path

    assert_response :success
    assert_includes response.body, "C SEO Title"
    assert_includes response.body, "C description"
  end

  test "create saves credit and stores slug in cookie for guest" do
    assert_difference("Credit.count", 1) do
      post credits_path, params: {
        credit: valid_credit_params
      }
    end

    credit = Credit.last

    assert_equal credit.slug, cookies["credit_id"]
    assert_redirected_to user_calculations_path
  end

  test "create saves credit and assigns it to current user" do
    sign_in @user

    assert_difference("Credit.count", 1) do
      post credits_path, params: {
        credit: valid_credit_params
      }
    end

    credit = Credit.last

    assert_includes @user.credits.reload, credit
    assert_nil cookies["credit_id"]
    assert_redirected_to user_calculations_path
  end

  test "create does not save invalid credit" do
    assert_no_difference("Credit.count") do
      post credits_path, params: {
        credit: invalid_credit_params
      }
    end

    assert_response :success
  end

  private

  def valid_credit_params
    {
      calculation_method: "equal-installments",
      amount_in_cent: 100_000_00,
      interest_ratio: 0.055,
      repayment_year: 10,
      months_one: 12,
      start: 2026,
      number_of_installments: 120,
      time_horizon: 10,
      start_at: Date.new(2026, 1, 1)
    }
  end

  def invalid_credit_params
    {
      calculation_method: "wrong-method",
      amount_in_cent: 0,
      interest_ratio: -1,
      repayment_year: 0,
      months_one: -1,
      start: 0,
      start_at: nil
    }
  end
end
