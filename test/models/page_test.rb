# == Schema Information
#
# Table name: pages
#
#  id         :bigint           not null, primary key
#  image      :string
#  is_visible :boolean          default(TRUE)
#  name       :string
#  position   :integer          default(1000)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
