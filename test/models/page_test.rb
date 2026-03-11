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

  test "accepts nested attributes for page_translations" do
    page = create_page

    assert_equal 3, page.page_translations.size

    translations = page.page_translations.index_by(&:locale)

    assert_equal "About Us", translations["en"].title
    assert_equal "Über uns", translations["de"].title
    assert_equal "O nama", translations["hr"].title
  end

  test "default scope orders by position ascending" do
    Page.delete_all

    create_page(2)
    create_page(1)
    create_page(3)

    assert_equal [1, 2, 3], Page.pluck(:position)
  end

  test "assigns position automatically when not provided" do
    page = create_page

    assert page.position.present?
    assert page.position > 0
  end

  test "is_visible defaults to true" do
    page = create_page

    assert_equal true, page.is_visible
  end

  test "can be set to not visible" do
    page = create_page

    page.update!(is_visible: false)

    assert_equal false, page.reload.is_visible
  end

  test "destroying page destroys all associated translations" do
    page = create_page
    translation_ids = page.page_translations.pluck(:id)

    assert_difference("PageTranslation.count", -3) do
      page.destroy
    end

    assert_empty PageTranslation.where(id: translation_ids)
  end

  test "initializes seo on new record" do
    page = Page.new

    assert_equal 1, page.seos.size
  end

  test "seo returns the first seo record" do
    page = create_page

    assert_equal page.seos.first, page.seo
  end

end
