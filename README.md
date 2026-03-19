# Financial Kit

Financial Kit is a Ruby on Rails application that provides four financial calculators used in Croatia: salary, author fee, service contract and loan calculator  
The application includes public pages with the four calculators, a user area where calculations can be saved and managed, and an admin CMS for monitoring and managing content.

The goal of the project was to build a complete Rails monolith that includes real-world features such as authentication, internationalization, testing, and a simple CMS.

The application is deployed on Hetzner cloud infrastructure and is available on [this link](https://financialkit.eu/de).

---

# Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/9bfcc5fa-400f-474e-bce2-50c0b1edb924" width="800">
</p>

*Main dashboard of Financial Kit – a Ruby on Rails application providing accurate financial calculators for Croatia, including salary (bruto/neto), loan, author fee, and service contract calculations.*

<br><br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/8d1ecb27-9798-47c5-b7ee-a256fb5333f5" width="800">
</p>

*Loan calculator with monthly payment estimation, interest calculation, and total repayment overview based on user-defined parameters.*

<br><br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/77305041-d8fc-497b-8751-ec194babd73f" width="800">
</p>

*Salary calculator for Croatia showing detailed bruto to net salary breakdown, including taxes, contributions, and final payout.*

<br><br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/dc7dc8d5-d4f5-44a4-89af-eabdf67e442a" width="800">
</p>

*Author fee calculator with automatic tax and contribution calculations, providing a clear overview of net income from freelance/author contracts in Croatia.*

<br><br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/65463541-5c2d-4d8d-a215-018e7ba78cc1" width="800">
</p>

*Service contract (ugovor o djelu) calculator displaying full cost breakdown, including taxes, contributions, and final net amount.*

---

## User

<p align="center">
  <img src="https://github.com/user-attachments/assets/49db90dc-18da-44dc-9312-5bc3ec1bad05" width="700">
</p>

*Authentication screen with secure login flow, providing access to user-specific financial tools and personalized dashboard.*

<br><br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/d9a3af2b-e64c-42ce-8243-8086049d169c" width="800">
</p>

*User dashboard displaying saved calculations, quick access to tools, and an overview of personal financial data.*

<br><br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/98b8b561-4baa-449a-b018-6749c0359280" width="400">
</p>

*Mobile user dashboard displaying saved calculations and quick access to tools.*

---

## Admin

<p align="center">
  <img src="https://github.com/user-attachments/assets/612de16f-91f5-4a50-b925-caf5b60f5db0" width="800">
</p>

*Admin dashboard for managing calculators, content, and application data with role-based access control.*

---

# Features

## Admin CMS

The application includes an admin CMS that allows administrators to manage users, application data, and public content. 

### User & Admin Management

Administrators can:

- View and manage administrators. Admins can be added but there is no registration functionality for admins.
- View and manage registered users. There is no mailer to check if the email is valid.
- Both admin and user models use the [gem Devise](https://github.com/heartcombo/devise)

### Tax Configuration

Salary, author fee and service contract calculations depend on city tax rates. Admins can add, update, and delete city tax rates.

### Calculator Monitoring

Admins can review all saved calculations performed in the application.

Available views include:

- Salary calculator results
- Author contract calculations
- Service contract calculations
- Loan calculations

This helps monitor application usage and verify calculations.

### Content Management

The CMS also includes a simple page builder.

Admins can create and manage pages, add and edit page sections and manage legal pages (privacy policy, terms of service).
This allows non-technical administrators to update public content without editing code. 

### Custom SEO

Pages and legal pages support nested SEO fields for managing meta tags. Calculators are implemented as static pages and do not include dynamic SEO configuration.

To address this, the CMS includes a dedicated SEO section where admins can enter URLs and meta tags. This ensures that all static pages, can have meta tags.


---

## Public Pages

The public part of the application contains informational pages and financial calculators. Included pages are:

- Home page
- About page
- Legal pages (privacy policy, terms of service)

These pages are fully managed through the CMS.

---

## Financial Calculators

The app currently includes four calculators.

### Salary Calculator

User can enter the amount, number of children, disability status, city tax and then can calculate:

- Gross to Net salary or
- Net to Gross salary

The calculation has an autocomplete input so the user can search for the city by name. 
The calculator displays a detailed breakdown of the payment structure.

### Author Fee Calculator

User can enter the amount, contract type, city tax and then can calculate:

- Gross to Net salary or
- Net to Gross salary

The calculation has an autocomplete input so the user can search for the city by name. 
The calculator displays a detailed breakdown of the payment structure.

### Service Contract Calculator

User can enter the amount, city tax and then can calculate:

- Gross to Net salary or
- Net to Gross salary

The calculation has an autocomplete input so the user can search for the city by name. 
The calculator displays a detailed breakdown of the payment structure.

### Loan Calculator

User can enter the amount, interest, repayment period and can select between equal annuity payments or equal principal payments. 
The calculator will present two tables: the first shows the monthly payments and the second shows yearly totals.


---

## User Accounts

User accounts are optional and exist primarily for saving calculations.

### Authentication

Users enter the email address and password. The email address won't be validated because there is no mailer yet. The email won't be misused for sending some promotional material nor will be sold to third parties.


Users can:

- Register
- Log in
- Access their saved calculations

### Saving Calculations

If a user performs a calculation while not logged in and clicks the "Save" button, the result will still be saved. For each calculator the user is optional, but a cookie will be saved to the user's browser. 


The workflow is:

1. A calculation is performed on the public calculator.
2. If the user clicks **Save**, they are redirected to login.
3. The calculation slug is temporarily stored using cookies.
4. After login, the calculation is automatically assigned to the user's account.

### User Dashboard

Logged-in users can view, edit and destroy previously saved calculations

---

# Internationalization

The application supports **three languages**: English, German and Croatian
All interface elements, calculators, and CMS content are translated using **Rails I18n**.

---

# Testing

The project uses minitest and includes automated tests for:

- Models
- Controllers
- Helpers
- Calculation logic (system test)

---

# Technical Stack

### Backend

- [Ruby on Rails](https://rubyonrails.org/)

### Frontend

- [TailwindCSS](https://tailwindcss.com/)
- [Stimulus](https://stimulus.hotwired.dev/handbook/installing)
- [SCSS](https://sass-lang.com/documentation/syntax/)

### Database

- [PostgreSQL](https://www.postgresql.org/)

### Other Tools & Libraries

- [gem Devise](https://github.com/heartcombo/devise)
- [Kaminari](https://github.com/kaminari/kaminari)
- [puma](https://github.com/puma/puma)
- [phosphoricons](https://phosphoricons.com/)
- [inline svg](https://github.com/jamesmartin/inline_svg)
- [carrierwave](https://github.com/carrierwaveuploader/carrierwave)
- [friendly_id](https://github.com/norman/friendly_id)
- [flatpickr datepicker](https://flatpickr.js.org/)
- and other 

---

# SEO

The application includes helper methods for SEO management:

- canonical URL generation
- meta description helpers
- keyword helpers

These ensure public pages are SEO-friendly.

# Analytics

The app uses [Umami](https://umami.is/) for traffic analytics.

---

# Deployment

The application is deployed on **Hetzner cloud infrastructure**.

Deployment includes:

- Linux server
- PostgreSQL database
- Rails production environment

The project shares the server with two other projects.

---

# Installation

To run the project locally:

### Clone the repository
```
git clone https://github.com/your-repo/financial-kit.git
cd financial-kit
bundle install
yarn install
rake db:create
rake db:migrate
rake db:seed
rails test tests/
bin/dev # to run the server locally
```

# Future Improvements and bug fixes

- a city must be selected / only typing it wont select it (bug) 
- add some cookie popup [tarteaucitron](https://tarteaucitron.io/) or so
- add GEO
- polish validations (models)
- improved UX/UI
    - calculation should start when the user stops entering values
    - polish how the app looks - only one type of sections is used
    - add descriptions to calculator fields
- extended test coverage - CMS is fully untested
- API endpoints for calculators
- enable exporting calculations to PDF
- add mailer for confirming emails

