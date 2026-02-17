module FriendlyIdMethods
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :slug_candidates, use: :slugged

    def should_generate_new_friendly_id?
      slug.blank? || title_changed?
    end
    def slug_candidates
      [:title] + Array.new(6) {|index| [:title, index+2]}
    end
  end
end
