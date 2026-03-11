# == Schema Information
#
# Table name: seos
#
#  id           :bigint           not null, primary key
#  image        :string
#  position     :integer          default(0)
#  seoable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  seoable_id   :integer
#
require "test_helper"

class SeoTest < ActiveSupport::TestCase
  def create_seo(position = nil)
    attrs = {
      seo_translations_attributes: [
        { title: "Financial Kit", locale: "en", description: "English desc", keywords: "finance, kit" },
        { title: "Finanzkit", locale: "de", description: "German desc", keywords: "finanzen, kit" },
        { title: "Financijski Kit", locale: "hr", description: "Croatian desc", keywords: "financije, kit" }
      ]
    }

    attrs[:position] = position unless position.nil?

    Seo.create!(attrs)
  end

  def create_page(position = nil)
    attrs = {
      page_translations_attributes: [
        { title: "About Us", locale: "en", slug: "about-us" },
        { title: "Über uns", locale: "de", slug: "uber-uns" },
        { title: "O nama", locale: "hr", slug: "o-nama" }
      ]
    }

    attrs[:position] = position unless position.nil?

    Page.create!(attrs)
  end

  test "accepts nested attributes for seo_translations" do
    seo = create_seo

    assert_equal 3, seo.seo_translations.size

    translations = seo.seo_translations.index_by(&:locale)

    assert_equal "Financial Kit", translations["en"].title
    assert_equal "Finanzkit", translations["de"].title
    assert_equal "Financijski Kit", translations["hr"].title
  end

  test "default scope orders by position ascending" do
    Seo.delete_all

    create_seo(2)
    create_seo(1)
    create_seo(3)

    assert_equal [1, 2, 3], Seo.pluck(:position)
  end

  test "can belong to a page" do
    page = create_page
    seo = create_seo

    page.seos << seo
    seo.reload

    assert_equal page, seo.seoable
    assert_equal "Page", seo.seoable_type
    assert_equal page.id, seo.seoable_id
  end

  test "can exist without seoable" do
    seo = create_seo

    assert_nil seo.seoable
  end

  test "destroying seo destroys all associated translations" do
    seo = create_seo
    translation_ids = seo.seo_translations.pluck(:id)

    assert_difference("SeoTranslation.count", -3) do
      seo.destroy
    end

    assert_empty SeoTranslation.where(id: translation_ids)
  end

  test "returns default title" do
    assert_equal "Financial Kit", Seo.default_title
  end

  test "returns default author" do
    assert_equal "Financial Kit", Seo.default_author
  end

  test "returns default description" do
    assert_equal "", Seo.default_description
  end

  test "returns default keywords" do
    assert_equal "", Seo.default_keywords
  end

  test "returns default image" do
    assert_equal "logo.png", Seo.default_image
  end
end
