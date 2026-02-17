module TranslationsHelper
  def tf(field, options={})
    locale = options[:locale] || I18n.locale
    t("activerecord.attributes.#{field}", locale: locale)
  end

  def pluralize_people(num, lang = :hr)
    if lang == :hr
      if (num % 10 == 2 || num % 10 == 3 || num % 10 == 4) && !(num % 100 == 12 || num % 100 == 13 || num % 100 == 14)
        "osobe"
      else
        "osoba"
      end
    else
      num == 1 ? "person" : "people"
    end
  end

  def pluralize_minutes(num, lang = :hr)
    if lang.to_sym == :hr
      "minuta"
    else
      num == 1 ? "minute" : "minutes"
    end
  end

end
