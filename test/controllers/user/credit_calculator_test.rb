require "test_helper"

class User::CreditsControllerTest < ActionDispatch::IntegrationTest
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

    @credit = @user.credits.create!(
      valid_credit_params
    )

    @other_user_credit = @other_user.credits.create!(
      valid_credit_params
    )

    sign_in @user
  end

  test "edit loads successfully for current user's credit" do
    get edit_user_credit_path(id: @credit.slug)
    assert_response :success
  end

  test "update changes credit for current user" do
    patch user_credit_path(id: @credit.slug), params: {
      credit: {
        amount_in_cent: 2000
      }
    }

    assert_redirected_to user_calculations_path
    assert_equal 200_000, @credit.reload.amount_in_cent
  end

  test "update does not change credit with invalid params" do
    old_amount = @credit.amount_in_cent

    patch user_credit_path(id: @credit.slug), params: {
      credit: invalid_credit_params
    }

    assert_response :success
    assert_equal old_amount, @credit.reload.amount_in_cent
  end

  test "destroy removes current user's credit" do
    assert_difference("Credit.count", -1) do
      delete user_credit_path(id: @credit.slug), headers: {
        "HTTP_ACCEPT" => "text/javascript"
      }
    end

    assert_response :success
  end

  test "current user cannot edit another user's credit" do
    get edit_user_credit_path(id: @other_user_credit.slug)
    assert_response :not_found
  end

  test "current user cannot update another user's credit" do
    patch user_credit_path(id: @other_user_credit.slug), params: {
      credit: {
        amount_in_cent: 2000
      }
    }

    assert_response :not_found
    assert_not_equal 200_000, @other_user_credit.reload.amount_in_cent
  end

  test "current user cannot destroy another user's credit" do
    assert_no_difference("Credit.count") do
      delete user_credit_path(id: @other_user_credit.slug), headers: {
        "HTTP_ACCEPT" => "text/javascript"
      }
    end

    assert_response :not_found
  end

  private

  def valid_credit_params
    {
      calculation_method: "equal-annuities",
      amount_in_cent: 100_000_00,
      interest_ratio: 0.05,
      repayment_year: 10,
      months_one: 12,
      start: 1,
      number_of_installments: 120,
      time_horizon: 10,
      start_at: Date.today
    }
  end

  def invalid_credit_params
    {
      calculation_method: nil,
      amount_in_cent: nil,
      interest_ratio: nil
    }
  end
end
