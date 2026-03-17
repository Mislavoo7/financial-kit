def seed_custom_seo
  Seo.create!(
    image: Rails.root.join("app/assets/images/seed_imgs/home.jpg").open,
    seoable: nil,
    seo_translations_attributes: {
      "0" => {
        title: "Kalkulator plaće (bruto - neto) Hrvatska",
        url: "/hr/salary-calculators/new",
        description: "Izračunaj neto i bruto plaću u Hrvatskoj. Brz i točan salary kalkulator s doprinosima i porezima.",
        keywords: "kalkulator plaće, bruto u neto, neto u bruto, plaća Hrvatska, izračun plaće",
        locale: "hr"
      },
      "1" => {
        title: "Salary Calculator Croatia (Gross - Net)",
        url: "/en/salary-calculators/new",
        description: "Calculate net and gross salary in Croatia. Accurate salary calculator with taxes and contributions.",
        keywords: "salary calculator croatia, gross to net, net to gross, croatia salary tax",
        locale: "en"
      },
      "2" => {
        title: "Gehaltsrechner Kroatien (Brutto - Netto)",
        url: "/de/salary-calculators/new",
        description: "Berechnen Sie Ihr Netto- und Bruttogehalt in Kroatien. Schnell und genau mit Steuern und Abgaben.",
        keywords: "gehaltsrechner kroatien, brutto netto, netto brutto, gehalt kroatien",
        locale: "de"
      }
    }
  )

  Seo.create!(
    image: Rails.root.join("app/assets/images/seed_imgs/home.jpg").open,
    seoable: nil,
    seo_translations_attributes: {
      "0" => {
        title: "Kalkulator autorskog honorara Hrvatska",
        url: "/hr/author-fee-calculators/new",
        description: "Izračunaj autorski honorar i neto isplatu. Uključeni porezi, doprinosi i prirez u Hrvatskoj.",
        keywords: "autorski honorar kalkulator, honorar neto, porez honorar, autorski ugovor hrvatska",
        locale: "hr"
      },
      "1" => {
        title: "Author Fee Calculator Croatia",
        url: "/en/author-fee-calculators/new",
        description: "Calculate author fees and net payout in Croatia. Includes taxes, contributions and local surtax.",
        keywords: "author fee calculator, croatia freelance tax, author contract croatia",
        locale: "en"
      },
      "2" => {
        title: "Honorare Rechner Kroatien",
        url: "/de/author-fee-calculators/new",
        description: "Berechnen Sie Ihr Autorenhonorar und die Nettoauszahlung in Kroatien mit allen Abgaben.",
        keywords: "honorar rechner kroatien, autorenhonorar, freiberufler kroatien",
        locale: "de"
      }
    }
  )

  Seo.create!(
    image: Rails.root.join("app/assets/images/seed_imgs/home.jpg").open,
    seoable: nil,
    seo_translations_attributes: {
      "0" => {
        title: "Kalkulator ugovora o djelu Hrvatska",
        url: "/hr/service-contract-calculators/new",
        description: "Izračunaj neto i bruto za ugovor o djelu. Brz izračun poreza i doprinosa u Hrvatskoj.",
        keywords: "ugovor o djelu kalkulator, neto bruto ugovor, porez ugovor o djelu",
        locale: "hr"
      },
      "1" => {
        title: "Service Contract Calculator Croatia",
        url: "/en/service-contract-calculators/new",
        description: "Calculate net and gross amounts for service contracts in Croatia with taxes and contributions.",
        keywords: "service contract calculator croatia, contract tax croatia, net gross contract",
        locale: "en"
      },
      "2" => {
        title: "Werkvertrag Rechner Kroatien",
        url: "/de/service-contract-calculators/new",
        description: "Berechnen Sie Netto- und Bruttobeträge für Werkverträge in Kroatien mit allen Abgaben.",
        keywords: "werkvertrag kroatien rechner, netto brutto vertrag kroatien",
        locale: "de"
      }
    }
  )

  Seo.create!(
    image: Rails.root.join("app/assets/images/seed_imgs/home.jpg").open,
    seoable: nil,
    seo_translations_attributes: {
      "0" => {
        title: "Kreditni kalkulator (rata i kamata)",
        url: "/hr/credits/new",
        description: "Izračunaj mjesečnu ratu kredita, kamatu i ukupni trošak. Jednostavan i brz kreditni kalkulator.",
        keywords: "kreditni kalkulator, rata kredita, kamata kredit, izračun kredita",
        locale: "hr"
      },
      "1" => {
        title: "Loan Calculator (Monthly Payment & Interest)",
        url: "/en/credits/new",
        description: "Calculate monthly loan payments, interest and total cost. Simple and accurate loan calculator.",
        keywords: "loan calculator, monthly payment, interest calculator, credit calculator",
        locale: "en"
      },
      "2" => {
        title: "Kreditrechner (Rate & Zinsen)",
        url: "/de/credits/new",
        description: "Berechnen Sie monatliche Kreditraten, Zinsen und Gesamtkosten einfach und schnell.",
        keywords: "kreditrechner, monatliche rate, zinsen berechnen, darlehen rechner",
        locale: "de"
      }
    }
  )

end
