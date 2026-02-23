module Slugable
  extend ActiveSupport::Concern

  included do
    before_save :add_slug
  end

  private

  def add_slug
    if slug.blank?
      self.slug = SecureRandom.hex(8)
    end
  end
end
