module PositionMethods
  extend ActiveSupport::Concern

  included do
    before_save :check_position
  end

  def check_position
    # add position onl on new items
    if !id
      begin
        model = eval("#{self.class.name}")
        if self.position.blank?
          self.position = model.all.last.position + 1
        end
      rescue
        self.position = 1
      end
    end
  end

end
