def seed_legal_pages
  # --- TERMS OF USE ---
  LegalPage.create!(
    legal_page_translations_attributes: {
      0 => {
        title: "Uvjeti korištenja",
        locale: "hr",
        content: """
          <h2>1. Prihvaćanje uvjeta</h2>
          <p>Korištenjem web aplikacije Financial Kit (\"Aplikacija\", \"usluga\") prihvaćate ove Uvjete korištenja. Ako se ne slažete, molimo nemojte koristiti Aplikaciju. Zadržavamo pravo izmjene ovih Uvjeta. Datum zadnje izmjene može biti prikazan na ovoj stranici.</p>

          <h2>2. Opis usluge</h2>
          <p>Financial Kit pruža financijske kalkulatore (npr. izračun kredita, plaće, autorskog honorara i izračune vezane uz ugovor o radu) prema važećim propisima Republike Hrvatske. Rezultati su informativne prirode.</p>

          <h2>3. Nije porezni / pravni savjet</h2>
          <p>Aplikacija ne pruža pravni, porezni ili financijski savjet. Izračuni mogu ovisiti o unosu korisnika, promjenama propisa i pojedinačnim okolnostima. Za službene obračune i odluke obratite se ovlaštenim stručnjacima (računovođa, porezni savjetnik, odvjetnik) ili nadležnim institucijama.</p>

          <h2>4. Korisnički račun i spremanje izračuna</h2>
          <p>Neke funkcionalnosti (npr. spremanje izračuna) mogu zahtijevati registraciju. Prilikom registracije korisnik je dužan unijeti točne podatke te čuvati pristupne podatke. Odgovorni ste za aktivnosti koje se događaju pod vašim računom.</p>

          <h2>5. Dopušteno korištenje</h2>
          <p>Ne smijete koristiti Aplikaciju na način koji je protuzakonit, koji može ugroziti sigurnost sustava ili ometati druge korisnike. Zabranjeno je pokušavati neovlašteno pristupiti sustavu ili podacima, automatizirano \"scrapanje\" bez dozvole te bilo kakvo zloupotrebljavanje usluge.</p>

          <h2>6. Dostupnost i promjene usluge</h2>
          <p>Aplikacija se pruža \"kakva jest\". Možemo povremeno mijenjati, privremeno onemogućiti ili ukinuti dio funkcionalnosti bez prethodne najave.</p>

          <h2>7. Intelektualno vlasništvo</h2>
          <p>Izvorni kod, dizajn i sadržaj Aplikacije zaštićeni su propisima o intelektualnom vlasništvu. Ne smijete kopirati, distribuirati ili javno koristiti sadržaj izvan dopuštenog bez prethodne pisane suglasnosti vlasnika.</p>

          <h2>8. Ograničenje odgovornosti</h2>
          <p>U najvećoj mjeri dopuštenoj zakonom, ne odgovaramo za bilo kakvu štetu (izravnu ili neizravnu) nastalu korištenjem Aplikacije, uključujući štetu zbog netočnih izračuna, propuštene dobiti, odluka donesenih na temelju rezultata ili nedostupnosti usluge.</p>

          <h2>9. Mjerodavno pravo i nadležnost</h2>
          <p>Na ove Uvjete primjenjuje se pravo Republike Hrvatske. Za sporove je nadležan stvarno nadležni sud u Republici Hrvatskoj, osim ako prisilni propisi o zaštiti potrošača određuju drukčije.</p>

          <h2>10. Kontakt</h2>
          <p>Za pitanja vezana uz ove Uvjete kontaktirajte nas na: <strong>kvesic.mislav@gmail.com</strong></p>
       """
      },
      1 => {
        title: "Terms of Use",
        locale: "en",
        content: """
          <h2>1. Acceptance of Terms</h2>
          <p>By accessing or using Financial Kit (the \"App\", the \"Service\"), you agree to these Terms of Use. If you do not agree, please do not use the App. We may update these Terms from time to time. The last updated date may be displayed on this page.</p>

          <h2>2. Service Description</h2>
          <p>Financial Kit provides financial calculators (e.g., loan calculations, Croatian salary calculations, copyright income, and employment-related calculations) based on Croatian regulations. Results are provided for informational purposes only.</p>

          <h2>3. No Legal / Tax / Financial Advice</h2>
          <p>The App does not provide legal, tax, or financial advice. Calculations may depend on user input, regulatory changes, and individual circumstances. For official calculations and decisions, consult qualified professionals or competent authorities.</p>

          <h2>4. User Accounts and Saved Calculations</h2>
          <p>Certain features (such as saving calculations) may require registration. You are responsible for maintaining the confidentiality of your credentials and for all activities under your account.</p>

          <h2>5. Acceptable Use</h2>
          <p>You must not use the App in any unlawful manner, attempt unauthorized access, disrupt the Service, or misuse it (including abusive automation or scraping without permission).</p>

          <h2>6. Availability and Changes</h2>
          <p>The App is provided \"as is\". We may modify, suspend, or discontinue parts of the Service at any time without notice.</p>

          <h2>7. Intellectual Property</h2>
          <p>The App's code, design, and content are protected by intellectual property laws. You may not copy, modify, distribute, or publicly use any part of the App beyond permitted use without prior written consent.</p>

          <h2>8. Limitation of Liability</h2>
          <p>To the maximum extent permitted by law, we are not liable for any damages arising from your use of the App, including reliance on calculation results, loss of profits, or service unavailability.</p>

          <h2>9. Governing Law and Jurisdiction</h2>
          <p>These Terms are governed by the laws of the Republic of Croatia. Courts in Croatia shall have jurisdiction, unless mandatory consumer protection rules provide otherwise.</p>

          <h2>10. Contact</h2>
          <p>For questions regarding these Terms, contact: <strong>kvesic.mislav@gmail.com</strong></p>
       """
      },
      2 => {
        title: "Nutzungsbedingungen",
        locale: "de",
        content: """
          <h2>1. Annahme der Bedingungen</h2>
          <p>Durch die Nutzung von Financial Kit (die „App“, der „Dienst“) stimmen Sie diesen Nutzungsbedingungen zu. Wenn Sie nicht zustimmen, nutzen Sie die App bitte nicht. Wir können diese Bedingungen gelegentlich aktualisieren. Das Datum der letzten Aktualisierung kann auf dieser Seite angezeigt werden.</p>

          <h2>2. Beschreibung des Dienstes</h2>
          <p>Financial Kit stellt Finanzrechner bereit (z. B. Kreditberechnungen, kroatische Gehaltsberechnungen, Honorare und arbeitsbezogene Berechnungen) auf Basis kroatischer Vorschriften. Ergebnisse dienen ausschließlich Informationszwecken.</p>

          <h2>3. Keine Rechts- / Steuer- / Finanzberatung</h2>
          <p>Die App stellt keine Rechts-, Steuer- oder Finanzberatung dar. Berechnungen können von Eingaben, Gesetzesänderungen und individuellen Umständen abhängen. Für offizielle Berechnungen und Entscheidungen wenden Sie sich bitte an qualifizierte Fachleute oder zuständige Stellen.</p>

          <h2>4. Benutzerkonto und gespeicherte Berechnungen</h2>
          <p>Bestimmte Funktionen (z. B. das Speichern von Berechnungen) erfordern ggf. eine Registrierung. Sie sind für die Vertraulichkeit Ihrer Zugangsdaten und alle Aktivitäten unter Ihrem Konto verantwortlich.</p>

          <h2>5. Zulässige Nutzung</h2>
          <p>Sie dürfen die App nicht rechtswidrig nutzen, keinen unbefugten Zugriff versuchen, den Dienst nicht stören und ihn nicht missbrauchen (einschließlich unerlaubter Automatisierung oder Scraping ohne Genehmigung).</p>

          <h2>6. Verfügbarkeit und Änderungen</h2>
          <p>Die App wird „wie sie ist“ bereitgestellt. Wir können Teile des Dienstes jederzeit ändern, aussetzen oder einstellen.</p>

          <h2>7. Geistiges Eigentum</h2>
          <p>Code, Design und Inhalte der App sind durch Rechte des geistigen Eigentums geschützt. Eine Nutzung über den erlaubten Rahmen hinaus (Kopieren, Ändern, Verbreiten) ist ohne vorherige schriftliche Zustimmung nicht gestattet.</p>

          <h2>8. Haftungsbeschränkung</h2>
          <p>Soweit gesetzlich zulässig, haften wir nicht für Schäden, die aus der Nutzung der App entstehen, einschließlich Vertrauen in Berechnungsergebnisse, entgangenen Gewinn oder Nichtverfügbarkeit des Dienstes.</p>

          <h2>9. Anwendbares Recht und Gerichtsstand</h2>
          <p>Es gilt das Recht der Republik Kroatien. Gerichtsstand sind die zuständigen Gerichte in Kroatien, soweit zwingende Verbraucherschutzvorschriften nichts anderes vorsehen.</p>

          <h2>10. Kontakt</h2>
          <p>Fragen zu diesen Bedingungen: <strong>kvesic.mislav@gmail.com</strong></p>
       """
      }
    },
    seos_attributes: {
      0 => {
        image: Rails.root.join("app/assets/images/seed_imgs/legal.jpg").open,
        seo_translations_attributes: {
          0 => {
            title: "Financial Kit – Uvjeti korištenja",
            description: "Uvjeti korištenja aplikacije Financial Kit. Informativni izračuni, odgovornost, korisnički računi i korištenje usluge.",
            keywords: "Financial Kit, uvjeti korištenja, financijski kalkulator, izračun plaće, izračun kredita",
            locale: "hr"
          },
          1 => {
            title: "Financial Kit – Terms of Use",
            description: "Terms of Use for Financial Kit. Informational calculations, liability, user accounts, and service usage rules.",
            keywords: "Financial Kit, terms of use, financial calculators, salary Croatia, loan calculator",
            locale: "en"
          },
          2 => {
            title: "Financial Kit – Nutzungsbedingungen",
            description: "Nutzungsbedingungen für Financial Kit. Informationsberechnungen, Haftung, Benutzerkonten und Regeln zur Nutzung des Dienstes.",
            keywords: "Financial Kit, Nutzungsbedingungen, Finanzrechner, Gehaltsrechner Kroatien, Kreditrechner",
            locale: "de"
          }
        }
      }
    }
  )

  # --- PRIVACY POLICY ---
  LegalPage.create!(
    legal_page_translations_attributes: {
      0 => {
        title: "Pravila o privatnosti",
        locale: "hr",
        content: """
          <p>Vaša privatnost nam je važna. Ova Politika privatnosti objašnjava kako obrađujemo osobne podatke u skladu s GDPR-om (EU) 2016/679.</p>

          <h2>1. Voditelj obrade</h2>
          <p><strong>Voditelj obrade:</strong> Mislav Kvesić<br><strong>Kontakt:</strong> kvesic.mislav@gmail.com</p>

          <h2>2. Koje podatke obrađujemo</h2>
          <ul>
            <li><strong>Podaci računa:</strong> e-mail adresa i podaci potrebni za autentikaciju (lozinka se pohranjuje kao siguran hash).</li>
            <li><strong>Spremljeni izračuni:</strong> podaci koje unesete u kalkulatore i odlučite spremiti (npr. parametri kredita, bruto/neto iznosi, odabrane postavke).</li>
            <li><strong>Tehnički podaci (analitika):</strong> koristimo Umami analitiku radi mjerenja osnovnih metrika korištenja (npr. broj posjeta, pregledane stranice). Ne koristimo podatke za oglašavanje.</li>
            <li><strong>Kontakt komunikacija:</strong> ako nam se javite e-mailom, obrađujemo sadržaj poruke i vašu adresu radi odgovora.</li>
          </ul>

          <h2>3. Svrhe i pravne osnove</h2>
          <ul>
            <li><strong>Pružanje usluge i spremanje izračuna</strong> – izvršavanje ugovora (čl. 6(1)(b) GDPR).</li>
            <li><strong>Sigurnost i sprječavanje zloupotrebe</strong> – legitimni interes (čl. 6(1)(f) GDPR).</li>
            <li><strong>Analitika (Umami)</strong> – legitimni interes za unaprjeđenje usluge ili, gdje je primjenjivo, privola (čl. 6(1)(a) GDPR). Ako koristimo kolačiće za analitiku, tražit ćemo privolu prije aktivacije.</li>
            <li><strong>Odgovori na upite</strong> – legitimni interes ili poduzimanje radnji na zahtjev ispitanika (čl. 6(1)(f)/(b) GDPR).</li>
          </ul>

          <h2>4. Kolačići i Umami</h2>
          <p>Umami se može konfigurirati kao analitika bez kolačića. Ako je Umami postavljen bez kolačića, ne koristimo analitičke kolačiće. Ako je postavljen tako da koristi kolačiće (npr. za prepoznavanje povratnih posjetitelja), analitika će se aktivirati tek nakon vaše privole putem bannera/izbornika kolačića.</p>

          <h2>5. Dijeljenje podataka</h2>
          <p>Ne prodajemo vaše podatke. Podatke dijelimo samo s pružateljima usluga hostinga/infrastrukture u mjeri nužnoj za rad sustava (npr. poslužitelji, baza). Ako koristimo Umami kao vanjsku uslugu, podaci analitike obrađuju se prema njihovim postavkama. Ne šaljemo podatke trećim stranama u marketinške svrhe.</p>

          <h2>6. Razdoblje čuvanja</h2>
          <ul>
            <li><strong>Podaci računa:</strong> dok imate aktivan račun, te razumno razdoblje nakon brisanja radi sigurnosti i usklađenosti (osim ako zakon zahtijeva dulje).</li>
            <li><strong>Spremljeni izračuni:</strong> dok ih ne obrišete ili dok ne obrišete račun.</li>
            <li><strong>Analitika:</strong> u agregiranom obliku koliko je potrebno za analizu i unaprjeđenje usluge.</li>
          </ul>

          <h2>7. Vaša prava</h2>
          <p>Imate prava na pristup, ispravak, brisanje, ograničenje obrade, prenosivost, prigovor te povlačenje privole (gdje je primjenjivo). Za ostvarenje prava kontaktirajte nas na e-mail iznad.</p>

          <h2>8. Sigurnost</h2>
          <p>Primjenjujemo razumne tehničke i organizacijske mjere (npr. hashiranje lozinki, ograničenje pristupa, osnovne sigurnosne kontrole). Nijedan sustav nije 100% siguran.</p>

          <h2>9. Brisanje računa</h2>
          <p>Možete zatražiti brisanje računa putem aplikacije (ako je omogućeno) ili putem e-maila. Brisanjem računa brišu se i spremljeni izračuni, osim ako postoji zakonska obveza čuvanja određenih podataka.</p>

          <h2>10. Kontakt i pritužbe</h2>
          <p>Kontakt: <strong>kvesic.mislav@gmail.com</strong>. Imate pravo podnijeti pritužbu nadzornom tijelu (AZOP).</p>
       """
      },
      1 => {
        title: "Privacy Policy",
        locale: "en",
        content: """
          <p>Your privacy matters. This Privacy Policy explains how we process personal data in accordance with the GDPR (EU) 2016/679.</p>

          <h2>1. Data Controller</h2>
          <p><strong>Controller:</strong> Mislav Kvesić<br><strong>Contact:</strong> kvesic.mislav@gmail.com</p>

          <h2>2. Data We Process</h2>
          <ul>
            <li><strong>Account data:</strong> email address and authentication data (password stored as a secure hash).</li>
            <li><strong>Saved calculations:</strong> inputs you choose to save (e.g., loan parameters, gross/net amounts, selected options).</li>
            <li><strong>Technical data (analytics):</strong> we use Umami analytics to measure basic usage metrics (e.g., visits, page views). We do not use analytics for advertising.</li>
            <li><strong>Contact communications:</strong> if you email us, we process your message content and email address to reply.</li>
          </ul>

          <h2>3. Purposes and Legal Bases</h2>
          <ul>
            <li><strong>Providing the Service & saving calculations</strong> – performance of a contract (Art. 6(1)(b) GDPR).</li>
            <li><strong>Security and abuse prevention</strong> – legitimate interest (Art. 6(1)(f) GDPR).</li>
            <li><strong>Analytics (Umami)</strong> – legitimate interest to improve the Service or, where applicable, consent (Art. 6(1)(a) GDPR). If analytics cookies are used, we will request consent before activation.</li>
            <li><strong>Responding to inquiries</strong> – legitimate interest or steps at the data subject’s request (Art. 6(1)(f)/(b) GDPR).</li>
          </ul>

          <h2>4. Cookies and Umami</h2>
          <p>Umami can be configured as cookie-less analytics. If configured cookie-less, we do not set analytics cookies. If configured to use cookies (e.g., to recognize returning visitors), analytics will be enabled only after you provide consent via a cookie banner/settings.</p>

          <h2>5. Data Sharing</h2>
          <p>We do not sell your data. We share data only with infrastructure providers (hosting, database) as necessary to run the Service. If Umami is used as an external service, analytics data is processed according to its configuration. We do not share data for marketing purposes.</p>

          <h2>6. Retention</h2>
          <ul>
            <li><strong>Account data:</strong> while your account is active and for a reasonable period after deletion for security/compliance (unless a longer period is required by law).</li>
            <li><strong>Saved calculations:</strong> until you delete them or delete your account.</li>
            <li><strong>Analytics:</strong> in aggregated form as needed for analysis and improvement.</li>
          </ul>

          <h2>7. Your Rights</h2>
          <p>You have the right to access, rectify, erase, restrict processing, data portability, object, and withdraw consent (where applicable). To exercise your rights, contact us using the email above.</p>

          <h2>8. Security</h2>
          <p>We apply reasonable technical and organizational measures (e.g., password hashing, access controls). No system is 100% secure.</p>

          <h2>9. Account Deletion</h2>
          <p>You may request account deletion via the App (if available) or by email. Deleting your account removes saved calculations unless we must retain certain data due to legal obligations.</p>

          <h2>10. Contact & Complaints</h2>
          <p>Contact: <strong>kvesic.mislav@gmail.com</strong>. You may lodge a complaint with a supervisory authority.</p>
       """
      },
      2 => {
        title: "Datenschutzrichtlinie",
        locale: "de",
        content: """
          <p>Ihre Privatsphäre ist uns wichtig. Diese Datenschutzerklärung erläutert die Verarbeitung personenbezogener Daten gemäß DSGVO (EU) 2016/679.</p>

          <h2>1. Verantwortlicher</h2>
          <p><strong>Verantwortlicher:</strong> Mislav Kvesić<br><strong>Kontakt:</strong> kvesic.mislav@gmail.com</p>

          <h2>2. Welche Daten wir verarbeiten</h2>
          <ul>
            <li><strong>Kontodaten:</strong> E-Mail-Adresse und Authentifizierungsdaten (Passwort als sicherer Hash gespeichert).</li>
            <li><strong>Gespeicherte Berechnungen:</strong> Eingaben, die Sie speichern möchten (z. B. Kreditparameter, Brutto/Netto-Beträge, gewählte Optionen).</li>
            <li><strong>Technische Daten (Analytics):</strong> Wir verwenden Umami Analytics zur Messung grundlegender Nutzungsmetriken (z. B. Besuche, Seitenaufrufe). Keine Nutzung zu Werbezwecken.</li>
            <li><strong>Kontaktkommunikation:</strong> Wenn Sie uns per E-Mail kontaktieren, verarbeiten wir Inhalt und Adresse zur Beantwortung.</li>
          </ul>

          <h2>3. Zwecke und Rechtsgrundlagen</h2>
          <ul>
            <li><strong>Bereitstellung des Dienstes & Speichern von Berechnungen</strong> – Vertragserfüllung (Art. 6(1)(b) DSGVO).</li>
            <li><strong>Sicherheit & Missbrauchsprävention</strong> – berechtigtes Interesse (Art. 6(1)(f) DSGVO).</li>
            <li><strong>Analytics (Umami)</strong> – berechtigtes Interesse zur Verbesserung oder, sofern erforderlich, Einwilligung (Art. 6(1)(a) DSGVO). Wenn Analytics-Cookies verwendet werden, aktivieren wir Analytics erst nach Ihrer Einwilligung.</li>
            <li><strong>Beantwortung von Anfragen</strong> – berechtigtes Interesse oder Maßnahmen auf Anfrage (Art. 6(1)(f)/(b) DSGVO).</li>
          </ul>

          <h2>4. Cookies und Umami</h2>
          <p>Umami kann ohne Cookies betrieben werden. Wenn cookie-less konfiguriert, setzen wir keine Analytics-Cookies. Falls Umami Cookies verwendet (z. B. zur Wiedererkennung), wird Analytics nur nach Ihrer Einwilligung über Cookie-Banner/Einstellungen aktiviert.</p>

          <h2>5. Weitergabe von Daten</h2>
          <p>Wir verkaufen keine Daten. Eine Weitergabe erfolgt nur an Infrastruktur-/Hosting-Anbieter, soweit für den Betrieb erforderlich. Bei externer Umami-Nutzung werden Analytics-Daten entsprechend der Konfiguration verarbeitet. Keine Weitergabe zu Marketingzwecken.</p>

          <h2>6. Speicherdauer</h2>
          <ul>
            <li><strong>Kontodaten:</strong> solange das Konto aktiv ist, plus angemessene Zeit nach Löschung für Sicherheit/Compliance (sofern gesetzlich nicht länger erforderlich).</li>
            <li><strong>Gespeicherte Berechnungen:</strong> bis Sie diese löschen oder Ihr Konto löschen.</li>
            <li><strong>Analytics:</strong> in aggregierter Form soweit erforderlich.</li>
          </ul>

          <h2>7. Ihre Rechte</h2>
          <p>Sie haben Rechte auf Auskunft, Berichtigung, Löschung, Einschränkung, Datenübertragbarkeit, Widerspruch sowie Widerruf der Einwilligung (sofern anwendbar). Kontaktieren Sie uns hierfür per E-Mail.</p>

          <h2>8. Sicherheit</h2>
          <p>Wir setzen angemessene technische und organisatorische Maßnahmen ein (z. B. Passwort-Hashing, Zugriffsbeschränkungen). Kein System ist vollständig sicher.</p>

          <h2>9. Kontolöschung</h2>
          <p>Sie können die Löschung Ihres Kontos über die App (falls verfügbar) oder per E-Mail beantragen. Mit der Kontolöschung werden gespeicherte Berechnungen entfernt, sofern keine gesetzlichen Aufbewahrungspflichten bestehen.</p>

          <h2>10. Kontakt & Beschwerden</h2>
          <p>Kontakt: <strong>kvesic.mislav@gmail.com</strong>. Sie können sich zudem bei einer Aufsichtsbehörde beschweren.</p>
       """
      }
    },
    seos_attributes: {
      0 => {
        image: Rails.root.join("app/assets/images/seed_imgs/legal.jpg").open,
        seo_translations_attributes: {
          0 => {
            title: "Financial Kit – Pravila o privatnosti",
            description: "Politika privatnosti za Financial Kit: korisnički računi, spremanje izračuna, Umami analitika i GDPR prava.",
            keywords: "Financial Kit, politika privatnosti, GDPR, umami, analitika, korisnički račun",
            locale: "hr"
          },
          1 => {
            title: "Financial Kit – Privacy Policy",
            description: "Privacy Policy for Financial Kit: user accounts, saved calculations, Umami analytics, and GDPR rights.",
            keywords: "Financial Kit, privacy policy, GDPR, Umami analytics, user account",
            locale: "en"
          },
          2 => {
            title: "Financial Kit – Datenschutz",
            description: "Datenschutz für Financial Kit: Benutzerkonten, gespeicherte Berechnungen, Umami Analytics und DSGVO-Rechte.",
            keywords: "Financial Kit, Datenschutz, DSGVO, Umami Analytics, Benutzerkonto",
            locale: "de"
          }
        }
      }
    }
  )
end
