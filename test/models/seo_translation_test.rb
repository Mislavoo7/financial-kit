# == Schema Information
#
# Table name: seo_translations
#
#  id          :bigint           not null, primary key
#  description :text
#  keywords    :string
#  locale      :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  seo_id      :integer
#
require "test_helper"

class SeoTranslationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
