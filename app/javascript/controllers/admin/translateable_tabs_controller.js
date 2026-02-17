
import { Controller } from "@hotwired/stimulus";

export default class TranslateableTabsController extends Controller {
  static targets = ["tab", "content"];

  connect() {
    const nav = document.createElement("nav");
    nav.classList.add("language-nav");
    this.element.prepend(nav);

    const locales = Array.from(this.element.querySelectorAll('[data-locale]')).map(tab => tab.dataset.locale);

    locales.forEach(locale => {
      const button = document.createElement('button');
      button.type = 'button';
      button.classList.add('language-tab');
      button.dataset.locale = locale;
      button.dataset.action = 'click->translateable-tabs#switchTab';
      button.dataset.translateableTabsTarget = 'tab';
      button.textContent = I18n.t(`lang.${locale}`);
      nav.appendChild(button);
    });

    const firstTabIndexWithError = this.getFirstTabIndexWithError();
    if (firstTabIndexWithError !== -1) {
      this.showTab(firstTabIndexWithError);
    } else {
      this.showTab(0);
    }

    this.checkAndAssignErrors();
  }

  switchTab(event) {
    event.preventDefault();
    const locale = event.currentTarget.dataset.locale;
    const index = Array.from(this.tabTargets).findIndex(tab => tab.dataset.locale === locale);
    this.showTab(index);
  }

  showTab(index) {
    this.tabTargets.forEach((tab, i) => {
      if (i === index) {
        tab.classList.add("is-active");
        this.contentTargets[i].classList.remove("hidden");
      } else {
        tab.classList.remove("is-active");
        this.contentTargets[i].classList.add("hidden");
      }
    });
  }

  checkAndAssignErrors() {
    this.tabTargets.forEach((tab, index) => {
      let hasErrors = this.checkForErrors(index);
      if (hasErrors) {
        tab.classList.add("has-errors");
      } else {
        tab.classList.remove("has-errors");
      }
    });
  }

  checkForErrors(index) {
    let content = this.contentTargets[index]
    return content.querySelectorAll('.validation-error').length > 0;
  }

  getFirstTabIndexWithError() {
    return Array.from(this.contentTargets).findIndex(content => content.querySelectorAll('.validation-error').length > 0);
  }
}


/*

<fieldset class="is-stacked">
  <div data-controller="translateable-tabs">
    <%= f.fields_for :admin_translations do |ff| %>
      <%= render 'admin_translation_fields', f: ff %>
    <% end %>
  </div>
</fieldset>

<div data-translateable-tabs-target="content" data-locale="<%= f.object.locale %>">
  <%= f.hidden_field :locale %>
  <div class="form-field__row">
    <div class="form-field">
      <%= f.label :title, class: 'label' %>
      <%= f.text_field :title, class: 'input' %>
    </div>
  </div>
  <div class="form-field__row">
    <div class="form-field">
      <%= f.label :content, class: 'label' %>
      <%= f.text_area :content, data: { controller: 'tinymce', editor_type: 'full' } %>
    </div>
  </div>
</div>

*/
