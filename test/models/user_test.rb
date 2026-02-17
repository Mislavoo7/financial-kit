# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  api_token              :string
#  blocked_at             :datetime
#  currency               :string           default("€")
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  theme                  :string           default("dark")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  language_id            :string           default("en")
#
# Indexes
#
#  index_users_on_api_token             (api_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
