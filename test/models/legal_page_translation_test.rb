# == Schema Information
#
# Table name: legal_page_translations
#
#  id            :bigint           not null, primary key
#  locale        :string
#  slug          :string
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  legal_page_id :integer
#
require "test_helper"

class LegalPageTranslationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
