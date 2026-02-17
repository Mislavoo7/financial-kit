module Admin::LanguageHelper
  def language_value(ff)
    if [0, 3, 6].include? ff.options[:child_index] 
      return 'hr'
    elsif [1, 4, 7].include? ff.options[:child_index] 
      return 'en'
    elsif [2, 5, 8].include? ff.options[:child_index] 
      return 'de'
    end
  end 

  def language_title(ff)
    case ff.options[:child_index]
    when 0
      return I18n.t('croatian')
    when 1 
      return I18n.t('english')
    when 2
      return I18n.t('german')
    end
  end

  def language_tabs(model, tags)
    divs = ""
    I18n.available_locales.each do |locale|
      div = "<div id='#{locale}' class='js-tabcontent_#{locale}'>"
      tags.each do |tab|
        unless model.translate(locale).blank? 
          text = model.translate(locale).send("#{tab.values[0]}") 
          div += "<#{tab.keys[0]}> #{text} </#{tab.keys[0]}>"
        end
      end
      div += "</div>"
      divs += div
    end
    return divs.html_safe
  end

  def language_tds(model, tags)
    tds = ""
    tags.each do |tab|
      tds += "<td>"
      tds += language_tabs(model, [tab.keys[0] => tab.values[0]])
      tds += "</td>"
    end
    return tds.html_safe
  end
end
