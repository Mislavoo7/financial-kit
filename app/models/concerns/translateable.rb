module Translateable
  extend ActiveSupport::Concern

  included do
    after_initialize :initialize_translations, if: :new_record?
  end

  def initialize_translations
    I18n.available_locales.each do |locale|
      self.translations.build(locale: locale.to_s) unless self.translations.map(&:locale).include?(locale.to_s)
    end
  end

  def translations
    send("#{self.class.name.underscore}_translations")
  end

  def translate(locale=I18n.locale)
    translations = send("#{self.model_name.param_key}_translations")
    translations.find_by(locale: locale.to_s)
  end

  def english_title
    translations.detect{ |t| t.locale == 'en' }.title
  end

  def slug
    if self.class.name == "Header"
      self.section_name
    else
      self.translate.slug
    end
  end

  def to_param
    begin
      self.slug
    rescue
      self.id
    end
  end

  module ClassMethods
    def findy_by_slug(id)
      underline_name = self.model_name.name.underscore
      model = eval("#{underline_name}_translation".camelize)
      find( model.friendly.find(id).public_send("#{underline_name}_id") )
    end
  end
end
