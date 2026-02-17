module VisibilityMethods
  extend ActiveSupport::Concern

  module ClassMethods
    def all_visible
      where(is_visible: true)
    end
  end
end
