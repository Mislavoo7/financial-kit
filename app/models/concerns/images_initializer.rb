module ImagesInitializer
  extend ActiveSupport::Concern

  included do
    has_many :images, as: :imageable, dependent: :destroy
    accepts_nested_attributes_for :images
    after_initialize :initialize_images, if: :new_record?
  end

  def initialize_images
#    self.images.build if self.images.blank?
  end
end
