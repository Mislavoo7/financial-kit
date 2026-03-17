# == Schema Information
#
# Table name: page_translations
#
#  id         :bigint           not null, primary key
#  locale     :string
#  slug       :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :integer
#
require "test_helper"

class PageTranslationTest < ActiveSupport::TestCase
  def create_page
    Page.create!(
      page_translations_attributes: [
        { title: "About Us", locale: "en", slug: "about-us" },
        { title: "Über uns", locale: "de", slug: "uber-uns" },
        { title: "O nama", locale: "hr", slug: "o-nama" }
      ]
    )
  end

  def build_translation(attrs = {})
    PageTranslation.new({
      page: create_page,
      title: "About Us",
      locale: "en",
      slug: "about-us"
    }.merge(attrs))
  end

  test "is valid with valid attributes" do
    translation = build_translation

    assert translation.valid?
  end

  test "is invalid without title" do
    translation = build_translation(title: nil)

    assert translation.invalid?
    assert translation.errors.added?(:title, :blank)
  end

  test "default scope orders by locale descending" do
    PageTranslation.delete_all

    page = create_page

    assert_equal [ "hr", "en", "de" ], PageTranslation.where(page: page).pluck(:locale)
  end

  test "belongs to a page" do
    translation = build_translation

    assert_instance_of Page, translation.page
  end
end
