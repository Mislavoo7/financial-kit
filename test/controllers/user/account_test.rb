require "test_helper"

class User::AccountsControllerTest < ActionDispatch::IntegrationTest
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

    sign_in @user
  end

  test "edit loads successfully" do
    get edit_user_accounts_path
    assert_response :success
  end

  test "update changes email" do
    patch user_accounts_path, params: {
      user: {
        email: "updated@example.com"
      }
    }

    assert_redirected_to user_root_path
    assert_equal "updated@example.com", @user.reload.email
  end

  test "update changes password when password is present" do
    patch user_accounts_path, params: {
      user: {
        email: @user.email,
        password: "newpassword123"
      }
    }

    assert_redirected_to user_root_path
    assert @user.reload.valid_password?("newpassword123")
  end

  test "update does not change password when password is blank" do
    old_encrypted_password = @user.encrypted_password

    patch user_accounts_path, params: {
      user: {
        email: "updated@example.com",
        password: ""
      }
    }

    assert_redirected_to user_root_path
    @user.reload
    assert_equal "updated@example.com", @user.email
    assert_equal old_encrypted_password, @user.encrypted_password
    assert @user.valid_password?("password123")
  end

  test "update redirects even with invalid params" do
    old_email = @user.email

    patch user_accounts_path, params: {
      user: {
        email: ""
      }
    }

    assert_redirected_to user_root_path
    assert_equal old_email, @user.reload.email
  end

  test "destroy_me removes current user" do
    assert_difference("User.count", -1) do
      get user_destroy_me_path
    end

    assert_redirected_to root_path
  end
end
