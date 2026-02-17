# == Schema Information
#
# Table name: sections
#
#  id               :bigint           not null, primary key
#  is_visible       :boolean          default(TRUE)
#  position         :integer          default(1000)
#  section_type     :string           default("simple")
#  sectionable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  sectionable_id   :integer
#
class Section < ApplicationRecord
  include VisibilityMethods
  include PositionMethods
  default_scope { order(:position) }
  include Translateable
  has_many :section_translations, dependent: :destroy
  accepts_nested_attributes_for :section_translations
  belongs_to :sectionable, polymorphic: true, required: false

  SECTION_TYPES = ["simple", "gray-box"]

  def self.allowed_types
    SECTION_TYPES.map{|s| [I18n.t("activerecord.attributes.section.section_types.#{s.gsub("-", "_")}", locale: "en"), s]}
  end

  def to_partial
    # What did you think it would be?
    self.section_type.gsub("-", "_")
  end
end
