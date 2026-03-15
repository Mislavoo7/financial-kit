require "application_system_test_case"

class CreditsTest < ApplicationSystemTestCase
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
        0 => {
          title: "Financial Kit",
          locale: "hr"
        },
        1 => {
          title: "Financial Kit",
          locale: "en"
        },
        2 => {
          title: "Financial Kit",
          locale: "de"
        }
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
  end

  test "guest calculates equal annuities credit" do
    visit "/hr/credits/new"

    page.execute_script <<~JS
      const toggle = document.getElementById('credit_calculation_method');
      if (!toggle.checked) toggle.click();
    JS

    fill_in "credit_amount_in_cent", with: "8000"
    fill_in "credit_interest_ratio", with: "2.5%"
    fill_in "credit_repayment_year", with: "5"
    fill_in "credit_months_one", with: "1"
    fill_in "credit_start", with: "4"

    page.execute_script <<~JS
      const startAt = document.getElementById('credit_start_at');
      startAt.value = '2024-03-01';
      startAt.dispatchEvent(new Event('input', { bubbles: true }));
      startAt.dispatchEvent(new Event('change', { bubbles: true }));
    JS

    assert_field "credit_number_of_installments", with: "60"
    assert_field "credit_time_horizon", with: "64"

    assert_selector "[data-credit-totals]"

    assert_text "2024"
    assert_text "918,55€"
    assert_text "755,79€"
    assert_text "162,76€"
    assert_text "7.244,21€"

    assert_text "2025"
    assert_text "1.703,75€"
    assert_text "1.540,23€"
    assert_text "163,52€"
    assert_text "5.703,98€"

    assert_text "2026"
    assert_text "1.703,75€"
    assert_text "1.579,17€"
    assert_text "124,58€"
    assert_text "4.124,81€"

    assert_text "2027"
    assert_text "1.703,74€"
    assert_text "1.619,08€"
    assert_text "84,66€"
    assert_text "2.505,73€"

    assert_text "2028"
    assert_text "1.703,73€"
    assert_text "1.660,04€"
    assert_text "43,69€"
    assert_text "845,69€"

    assert_text "2029"
    assert_text "851,88€"
    assert_text "845,70€"
    assert_text "6,18€"

    assert_selector "tr.credit-total-row", text: "8.585,40€"
    assert_selector "tr.credit-total-row", text: "8.000,01€"
    assert_selector "tr.credit-total-row", text: "585,39€"
  end
end
