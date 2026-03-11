# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#
require "test_helper"

class AdminTest < ActiveSupport::TestCase
  def create_admin(email = "admin@example.com", password = "password123")
    Admin.create!(
      email: email,
      password: password,
      password_confirmation: password
    )
  end

  def build_admin(attrs = {})
    Admin.new({
      email: "admin@example.com",
      password: "password123",
      password_confirmation: "password123"
    }.merge(attrs))
  end

  test "is valid with valid attributes" do
    admin = build_admin

    assert admin.valid?
  end

  test "is invalid without email" do
    admin = build_admin(email: nil)

    assert admin.invalid?
    assert admin.errors.added?(:email, :blank)
  end

  test "is invalid without password" do
    admin = build_admin(password: nil, password_confirmation: nil)

    assert admin.invalid?
    assert admin.errors[:password].present?
  end

  test "is invalid with duplicate email" do
    create_admin("admin@example.com")

    admin = build_admin(email: "admin@example.com")

    assert admin.invalid?
    assert admin.errors[:email].present?
  end
end
