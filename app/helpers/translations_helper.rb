module TranslationsHelper
  def tf(field, options = {})
    locale = options[:locale] || I18n.locale
    t("activerecord.attributes.#{field}", locale: locale)
  end
end
