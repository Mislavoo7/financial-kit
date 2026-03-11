module PositionMethods
  extend ActiveSupport::Concern

  included do
    before_validation :check_position, on: :create
    validates :position, numericality: { greater_than: 0 }
  end

  def check_position
    return unless new_record?
    return if position.present? && position > 0

    last_position = self.class.order(:position).last&.position
    self.position = last_position ? last_position + 1 : 1
  end
end
