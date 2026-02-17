module SeosInitializer
  extend ActiveSupport::Concern

  included do
    has_many :seos, as: :seoable, dependent: :destroy
    accepts_nested_attributes_for :seos
    after_initialize :initialize_seos, if: :new_record?
  end

  def initialize_seos
    self.seos.build if self.seos.blank?
  end

  def seo
    seos.first
  end
end
