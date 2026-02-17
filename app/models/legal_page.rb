# == Schema Information
#
# Table name: legal_pages
#
#  id         :bigint           not null, primary key
#  is_visible :boolean          default(TRUE)
#  position   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class LegalPage < ApplicationRecord
  include SeosInitializer
  include VisibilityMethods
  include PositionMethods
  include Translateable

  has_many :legal_page_translations, dependent: :destroy
  accepts_nested_attributes_for :legal_page_translations

  default_scope { order(:position) }
end
