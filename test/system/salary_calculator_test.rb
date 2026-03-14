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
    page = Page.create!(
      image: Rails.root.join("app/assets/images/seed_imgs/home.jpg").open,
      name: "home",
      page_translations_attributes: {
        0 => { title: "Financial Kit", locale: "hr" },
        1 => { title: "Financial Kit", locale: "en" },
        2 => { title: "Financial Kit", locale: "de" }
      },
      seos_attributes: {
        0 => {
          image: Rails.root.join("app/assets/images/seed_imgs/home.jpg").open,
          seo_translations_attributes: {
            0 => {
              title: "Financial Kit – Financijski kalkulatori za Hrvatsku",
              description: "",
              keywords: "",
              locale: "hr"
            },
            1 => {
              title: "Financial Kit – Financial Calculators for Croatia",
              description: "",
              keywords: "",
              locale: "en"
            },
            2 => {
              title: "Financial Kit – Finanzrechner für Kroatien",
              description: "",
              keywords: "",
              locale: "de"
            }
          }
        }
      }
    )

    page
  end

  def setup
    @home_page = create_home_page
    @about_page = create_about_page
    @seo = @home_page.seo

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

  page.execute_script <<~JS
    const cityField = document.getElementById('salary_calculator_city_tax_rate_id');
    cityField.value = '319';
    cityField.dispatchEvent(new Event('input', { bubbles: true }));
    cityField.dispatchEvent(new Event('change', { bubbles: true }));
  JS

  page.execute_script <<~JS
    const toggle = document.getElementById('salary_calculator_calculation_type');
    if (toggle.checked) {
      toggle.click();
    }
  JS

  assert_selector "[data-brut]", text: "1.625,00€"
  assert_selector "[data-employer-to-pay]", text: "1.893,12€"
  assert_selector "[data-net]", text: "1.300,00€"

  assert_selector "input#salary_calculator_brut_in_cent[value='162500']", visible: false
  assert_selector "input#salary_calculator_employer_to_pay_in_cent[value='189312']", visible: false
  assert_selector "input#salary_calculator_net_in_cent[value='130000']", visible: false
end
end
