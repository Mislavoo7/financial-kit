# == Schema Information
#
# Table name: section_translations
#
#  id         :bigint           not null, primary key
#  locale     :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  section_id :integer
#
class SectionTranslation < ApplicationRecord
  default_scope { order(locale: :desc) }
  belongs_to :section
  validates_presence_of :title
  has_rich_text :content
end
