# == Schema Information
#
# Table name: seo_translations
#
#  id          :bigint           not null, primary key
#  description :text
#  keywords    :string
#  locale      :string
#  title       :string
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  seo_id      :integer
#
require "test_helper"

class SeoTranslationTest < ActiveSupport::TestCase
  def create_seo
    Seo.create!(
      seo_translations_attributes: [
        { title: "Financial Kit", locale: "en", description: "English desc", keywords: "finance, kit" },
        { title: "Finanzkit", locale: "de", description: "German desc", keywords: "finanzen, kit" },
        { title: "Financijski Kit", locale: "hr", description: "Croatian desc", keywords: "financije, kit" }
      ]
    )
  end

  def build_translation(attrs = {})
    SeoTranslation.new({
      seo: create_seo,
      title: "Financial Kit",
      locale: "en",
      description: "English desc",
      keywords: "finance, kit"
    }.merge(attrs))
  end

  test "is valid with valid attributes" do
    translation = build_translation

    assert translation.valid?
  end

  test "default scope orders by locale descending" do
    SeoTranslation.delete_all

    seo = create_seo

    assert_equal ["hr", "en", "de"], SeoTranslation.where(seo: seo).pluck(:locale)
  end

  test "belongs to a seo" do
    translation = build_translation

    assert_instance_of Seo, translation.seo
  end
end
