module ApplicationHelper
  def external_url(link)
    return nil if link.blank?

    if link =~ /http/
      link
    else
      "http://#{link}"
    end
  end

  def prepare_url(locale)
    return "javascript:void(0);" if locale == I18n.locale
    return url_for(locale: locale)
  end

  def path_is_active?(paths)
    paths.each do |path| 
      return "page" if current_page?(path) 
    end
  end
end
