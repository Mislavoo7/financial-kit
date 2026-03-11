# == Schema Information
#
# Table name: sections
#
#  id               :bigint           not null, primary key
#  is_visible       :boolean          default(TRUE)
#  position         :integer          default(1000)
#  section_type     :string           default("simple")
#  sectionable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  sectionable_id   :integer
#
require "test_helper"

class SectionTest < ActiveSupport::TestCase
  def create_section(position = nil, section_type = nil)
    attrs = {
      section_translations_attributes: [
        { title: "Introduction", locale: "en" },
        { title: "Einführung", locale: "de" },
        { title: "Uvod", locale: "hr" }
      ]
    }

    attrs[:position] = position unless position.nil?
    attrs[:section_type] = section_type unless section_type.nil?

    Section.create!(attrs)
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

  test "accepts nested attributes for section_translations" do
    section = create_section

    assert_equal 3, section.section_translations.size

    translations = section.section_translations.index_by(&:locale)

    assert_equal "Introduction", translations["en"].title
    assert_equal "Einführung", translations["de"].title
    assert_equal "Uvod", translations["hr"].title
  end

  test "default scope orders by position ascending" do
    Section.delete_all

    create_section(2)
    create_section(1)
    create_section(3)

    assert_equal [1, 2, 3], Section.pluck(:position)
  end

  test "assigns position automatically when not provided" do
    section = create_section

    assert section.position.present?
    assert section.position > 0
  end

  test "is_visible defaults to true" do
    section = create_section

    assert_equal true, section.is_visible
  end

  test "can be set to not visible" do
    section = create_section

    section.update!(is_visible: false)

    assert_equal false, section.reload.is_visible
  end

  test "destroying section destroys all associated translations" do
    section = create_section
    translation_ids = section.section_translations.pluck(:id)

    assert_difference("SectionTranslation.count", -3) do
      section.destroy
    end

    assert_empty SectionTranslation.where(id: translation_ids)
  end

  test "allowed_types returns translated labels with values" do
    assert_equal [
      [I18n.t("activerecord.attributes.section.section_types.simple", locale: "en"), "simple"],
      [I18n.t("activerecord.attributes.section.section_types.gray_box", locale: "en"), "gray-box"]
    ], Section.allowed_types
  end

  test "to_partial converts dashes to underscores" do
    section = create_section(nil, "gray-box")

    assert_equal "gray_box", section.to_partial
  end

  test "can belong to a page" do
    page = create_page
    section = create_section(nil, "gray-box")

    page.sections << section

    assert_equal page, section.sectionable
    assert_equal "Page", section.sectionable_type
    assert_equal page.id, section.sectionable_id
  end
end
