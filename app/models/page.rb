# == Schema Information
#
# Table name: pages
#
#  id         :bigint           not null, primary key
#  image      :string
#  is_visible :boolean          default(TRUE)
#  name       :string
#  position   :integer          default(1000)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Page < ApplicationRecord
  include SeosInitializer
  include SectionsInitializer
  include VisibilityMethods
  include PositionMethods
  include Translateable
  has_many :page_translations, dependent: :destroy
  accepts_nested_attributes_for :page_translations

  default_scope { order(:position) }

  mount_uploader :image, ImageUploader
end
