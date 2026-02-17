# == Schema Information
#
# Table name: legal_pages
#
#  id         :bigint           not null, primary key
#  is_visible :boolean          default(TRUE)
#  position   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class LegalPageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
