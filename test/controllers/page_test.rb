require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  def create_about_page(position = nil)
    attrs = {
      name: "about",
      page_translations_attributes: [
        { title: "About Us", locale: "en", slug: "about-us" },
        { title: "Über uns", locale: "de", slug: "uber-uns" },
        { title: "O nama", locale: "hr", slug: "o-nama" }
      ]
    }

    attrs[:position] = position unless position.nil?

    Page.create!(attrs)
  end

  def create_home_page(position = nil)
    attrs = {
      name: "home",
      page_translations_attributes: [
        { title: "Financial Kit", locale: "en", slug: "f-k" },
        { title: "Financial Kit", locale: "de", slug: "f-k" },
        { title: "Financial Kit", locale: "hr", slug: "f-k" }
      ]
    }

    attrs[:position] = position unless position.nil?

    Page.create!(attrs)
  end

  def add_sections(page, position = nil)
    attrs = {
      section_translations_attributes: [
        { title: "Visible section", locale: "en" },
        { title: "Visible section", locale: "de" },
        { title: "Vidljiva sekcija", locale: "hr" }
      ]
    }
    attrs[:position] = position unless position.nil?
    visible_section = Section.new(attrs)
    page.sections << visible_section
    visible_section.save!

    hidden_attrs = {
      is_visible: false,
      section_translations_attributes: [
        { title: "Hidden section", locale: "en" },
        { title: "Hidden section", locale: "de" },
        { title: "Skrivena sekcija", locale: "hr" }
      ]
    }
    hidden_attrs[:position] = position + 1 if position.present?
    hidden_section = Section.new(hidden_attrs)
    page.sections << hidden_section
    hidden_section.save!

    [visible_section, hidden_section]
  end

  def setup
    @home_page = create_home_page
    @about_page = create_about_page

    @home_visible_section, @home_hidden_section = add_sections(@home_page, 1)
    @about_visible_section, @about_hidden_section = add_sections(@about_page, 1)

    @home_translation = @home_page.page_translations.find_by!(locale: "hr")
    @about_translation = @about_page.page_translations.find_by!(locale: "hr")
  end

  test "show loads page by translation slug" do
    get page_path(id: @about_translation.slug)
    assert_response :success
  end

  test "show raises not found for invalid slug" do
    get page_path(id: "nepostojeci-slug")
    assert_response :not_found
  end

  test "index loads successfully" do
    get root_path
    assert_response :success
  end
end
