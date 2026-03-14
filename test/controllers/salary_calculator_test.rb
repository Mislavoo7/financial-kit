require "application_system_test_case"

class SalaryCalculatorsTest < ApplicationSystemTestCase
  def create_about_page(position = nil)
    attrs = {
      name: "about",
      page_translations_attributes: [
        { title: "About Us", locale: "en" },
        { title: "Über uns", locale: "de" },
        { title: "O nama", locale: "hr" }
      ]
    }

    attrs[:position] = position unless position.nil?
    Page.create!(attrs)
  end

  def create_home_page(position = nil)
    attrs = {
      name: "home",
      page_translations_attributes: [
        { title: "Financial Kit", locale: "en" },
        { title: "Financial Kit", locale: "de" },
        { title: "Financial Kit", locale: "hr" }
      ]
    }

    attrs[:position] = position unless position.nil?
    Page.create!(attrs)
  end

  def create_salary_calculator_page(position = nil)
    attrs = {
      name: "salary_calculators",
      page_translations_attributes: [
        { title: "Salary Calculator", locale: "en" },
        { title: "Gehaltsrechner", locale: "de" },
        { title: "Kalkulator plaće", locale: "hr" }
      ]
    }

    attrs[:position] = position unless position.nil?
    Page.create!(attrs)
  end

  def setup
    @home_page = create_home_page
    @about_page = create_about_page
    @salary_page = create_salary_calculator_page

    @city_tax_rate = CityTaxRate.create!(
      id: 319,
      title: "Osijek",
      higher_rate: 30,
      lower_rate: 20
    )
  end

  test "guest calculates net to brut salary" do
    visit "/hr/salary_calculators/new"

    fill_in "salary_calculator_amount_in_cent", with: "1300"
    fill_in "salary_calculator_kids_num", with: "2"
    fill_in "salary_calculator_dependents_num", with: "0"
    choose "salary_calculator_disability_no_disability"

    find("#salary_calculator_city_tax_rate_id", visible: false).set("319")
    find("#salary_calculator_calculation_type", visible: :all).uncheck

    assert_text "1.625,00€"
    assert_text "1.893,12€"
    assert_text "1.300,00€"

    assert_selector "input#salary_calculator_brut_in_cent[value='162500']", visible: false
    assert_selector "input#salary_calculator_employer_to_pay_in_cent[value='189312']", visible: false
    assert_selector "input#salary_calculator_net_in_cent[value='130000']", visible: false
  end
end
