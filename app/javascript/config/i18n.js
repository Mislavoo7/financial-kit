import { I18n } from "i18n-js";

const userLocale = document.documentElement.lang;
const i18n = new I18n();

let translations = {};

try {
  translations = require('./translations.json');
} catch (error) {
  console.info("Translation file not generated");
}

i18n.translations = translations;
i18n.defaultLocale = "en";
i18n.locale = userLocale;
i18n.enableFallback = true;

window.I18n = i18n;

export { i18n };
