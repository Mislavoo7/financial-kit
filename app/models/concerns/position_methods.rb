module PositionMethods
  extend ActiveSupport::Concern

  included do
    before_save :check_position

    validates :position,
      numericality: { greater_than: 0 },
      allow_nil: true
  end

  def check_position
    return if id # if not new, pass

    if position.blank?
      last_position = self.class.order(:position).last&.position
      self.position = last_position ? last_position + 1 : 1
    end
  end
end
