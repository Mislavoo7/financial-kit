module ApplicationHelper
  def prepare_url(locale)
    return "javascript:void(0);" if locale == I18n.locale
    url_for(locale: locale)
  end

  def path_is_active?(paths)
    paths.each do |path|
      return "page" if current_page?(path)
    end
  end
end
