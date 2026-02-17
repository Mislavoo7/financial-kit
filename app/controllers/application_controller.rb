class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_pages
  before_action :set_locale
  before_action :set_legal_pages

  # Skip CSRF protection for API requests
  skip_before_action :verify_authenticity_token, if: :json_request?
  
  private

  def json_request?
    request.format.json?
  end


  def default_url_options(options = {})
    # user can change his pref language - NO! i wont use this bc when the user chooses :de in the app it will be automaticly changed by the default :en in the web. I will add some account settins to change currency, language an theme
##    if current_user and current_user.language_id != locale.to_s
##      current_user.update(language_id: locale.to_s)
##    end

    { locale: I18n.locale }.merge options
  end

  def set_locale
    I18n.locale = params[:locale].presence || I18n.default_locale
  end

  def make_action_mailer_use_request_host_and_protocol
    ActionMailer::Base.default_url_options[:protocol] = request.protocol
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def js_toast_response(message, type='success')
    type = type.to_s
    return { js: "dispatchWarningToast('#{message}')" } if type == 'warning'
    return { js: "dispatchAlertToast('#{message}')" } if type == 'alert'
    return { js: "dispatchInfoToast('#{message}')" } if type == 'info'
    return { js: "dispatchSuccessToast('#{message}')" }
  end

  def set_absolute_url
    @web_url = "#{request.protocol}#{request.host_with_port}"
    @absolute_url = "#{@web_url}#{request.fullpath}"
  end

  def set_pages
    @pages = Page.where(name: [
      "home", "about"    
    ]).index_by(&:name)

    @home_page = @pages["home"]
    @about_page = @pages["about"]
  end

  def set_legal_pages
    @legal_pages = LegalPage.all_visible
  end
end
