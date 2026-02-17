module SectionsInitializer
  extend ActiveSupport::Concern

  included do
    has_many :sections, as: :sectionable, dependent: :destroy
    accepts_nested_attributes_for :sections
    after_initialize :initialize_sections, if: :new_record?
  end

  def initialize_sections
    #self.images.build if self.images.blank?
  end
end
