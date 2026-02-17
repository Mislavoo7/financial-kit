def seed_home
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
      },
    },
    seos_attributes: {
      0 => {
        image: Rails.root.join("app/assets/images/seed_imgs/home.jpg").open,
        seo_translations_attributes: {
          0 => {
            title: "Financial Kit – Financijski kalkulatori za Hrvatsku",
            description: "Financial Kit je web aplikacija s preciznim financijskim kalkulatorima za Hrvatsku. Izračun kredita, plaće (bruto/neto), autorskog honorara i ugovora o radu prema aktualnim poreznim stopama i propisima.",
            keywords: "financijski kalkulator, izračun kredita, bruto neto, plaća hrvatska, autorski honorar, ugovor o radu, porezne stope",
            locale: "hr"
          },
          1 => {
            title: "Financial Kit – Financial Calculators for Croatia",
            description: "Financial Kit provides accurate financial calculators tailored to Croatian legislation. Calculate loan payments, salary (gross/net), copyright income and employment contracts using current tax regulations.",
            keywords: "financial calculator, loan calculator, salary Croatia, gross to net, Croatian tax, employment contract calculator",
            locale: "en"
          },
          2 => {
            title: "Financial Kit – Finanzrechner für Kroatien",
            description: "Financial Kit ist eine Webanwendung mit präzisen Finanzrechnern für Kroatien. Berechnen Sie Kreditraten, Gehalt (Brutto/Netto), Honorare und Arbeitsverträge gemäß aktuellen Steuervorschriften.",
            keywords: "Finanzrechner Kroatien, Kreditrechner, Brutto Netto Kroatien, Gehaltsrechner, Arbeitsvertrag Kroatien",
            locale: "de"
          }
        }
      }
    }
  )

  s1 = Section.create!(
    section_translations_attributes: {
      0 => {
        title: "Financial Kit",
        content: "<p>Financial Kit je skup jednostavnih i pouzdanih financijskih kalkulatora prilagođenih zakonodavnom okviru Republike Hrvatske.</p><p>Aplikacija omogućuje brze i transparentne izračune za najčešće financijske situacije – od kredita do obračuna plaće i honorara.</p>",
        locale: "hr"
      },
      1 => {
        title: "Financial Kit",
        content: "<p>Financial Kit is a collection of simple and reliable financial calculators tailored to Croatian legislation.</p><p>The application provides fast and transparent calculations for common financial scenarios – from loan simulations to salary and contract income calculations.</p>",
        locale: "en"
      },
      2 => {
        title: "Financial Kit",
        content: "<p>Financial Kit ist eine Sammlung einfacher und zuverlässiger Finanzrechner, die auf die kroatische Gesetzgebung abgestimmt sind.</p><p>Die Anwendung ermöglicht schnelle und transparente Berechnungen für typische finanzielle Situationen – von Kreditberechnungen bis zur Gehalts- und Honorarberechnung.</p>",
        locale: "de"
      },
    },
    position: 0
  )
  page.sections << s1

  s2 = Section.create!(
    section_translations_attributes: {
      0 => {
        title: "Dostupni kalkulatori",
        content: "<ul><li><strong>Izračun kredita</strong> – usporedba jednakih anuiteta i jednakih rata.</li><li><strong>Izračun plaće</strong> – bruto u neto i neto u bruto uz porezne stope i osobne olakšice.</li><li><strong>Autorski honorar</strong> – obračun poreza i doprinosa.</li><li><strong>Ugovor o radu</strong> – detaljan izračun primanja prema važećim propisima.</li></ul>",
        locale: "hr"
      },
      1 => {
        title: "Available Calculators",
        content: "<ul><li><strong>Loan Calculator</strong> – comparison of annuity and fixed principal repayment models.</li><li><strong>Salary Calculator</strong> – gross to net and net to gross calculation including tax allowances.</li><li><strong>Copyright Income Calculator</strong> – tax and contribution calculation.</li><li><strong>Employment Contract Calculator</strong> – detailed income breakdown based on current regulations.</li></ul>",
        locale: "en"
      },
      2 => {
        title: "Verfügbare Rechner",
        content: "<ul><li><strong>Kreditrechner</strong> – Vergleich von Annuitäten- und Tilgungsmodellen.</li><li><strong>Gehaltsrechner</strong> – Brutto- und Nettoberechnung inklusive Steuerfreibeträgen.</li><li><strong>Honorarechner</strong> – Berechnung von Steuern und Abgaben.</li><li><strong>Arbeitsvertragsrechner</strong> – detaillierte Einkommensberechnung gemäß aktuellen Vorschriften.</li></ul>",
        locale: "de"
      },
    },
    position: 1
  )
  page.sections << s2
end


def seed_about
  page = Page.create!(
    image: Rails.root.join("app/assets/images/seed_imgs/about.jpg").open,
    name: "about",
    page_translations_attributes: {
      0 => { title: "O projektu", locale: "hr" },
      1 => { title: "About the Project", locale: "en" },
      2 => { title: "Über das Projekt", locale: "de" },
    },
    seos_attributes: {
      0 => {
        image: Rails.root.join("app/assets/images/seed_imgs/about.jpg").open,
        seo_translations_attributes: {
          0 => {
            title: "O projektu | Financial Kit",
            description: "Financial Kit je tehnički projekt fokusiran na precizne financijske izračune prema hrvatskom zakonodavnom okviru.",
            keywords: "financial kit, financijski kalkulator, hrvatski porezi, bruto neto",
            locale: "hr"
          },
          1 => {
            title: "About | Financial Kit",
            description: "Financial Kit is a technical project focused on accurate financial calculations aligned with Croatian legislation.",
            keywords: "financial kit, finance calculator, croatian tax, backend project",
            locale: "en"
          },
          2 => {
            title: "Über das Projekt | Financial Kit",
            description: "Financial Kit ist ein technisches Projekt mit Fokus auf präzise Finanzberechnungen gemäß kroatischer Gesetzgebung.",
            keywords: "Financial Kit, Finanzrechner Kroatien, Backend Projekt",
            locale: "de"
          }
        }
      }
    }
  )

  s1 = Section.create!(
    section_translations_attributes: {
      0 => {
        title: "Ukratko",
        content: "<p>Financial Kit je projekt nastao s ciljem pružanja točnih i transparentnih financijskih izračuna. Fokus je na jasnoj logici, provjerljivim formulama i jednostavnom korisničkom sučelju.</p>",
        locale: "hr"
      },
      1 => {
        title: "In Short",
        content: "<p>Financial Kit was created to provide accurate and transparent financial calculations. The focus is on clear logic, verifiable formulas, and a straightforward user interface.</p>",
        locale: "en"
      },
      2 => {
        title: "Kurz gesagt",
        content: "<p>Financial Kit wurde entwickelt, um präzise und transparente Finanzberechnungen bereitzustellen. Der Schwerpunkt liegt auf klarer Logik, überprüfbaren Formeln und einer einfachen Benutzeroberfläche.</p>",
        locale: "de"
      },
    },
    position: 0
  )
  page.sections << s1
end
