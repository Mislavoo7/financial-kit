# == Schema Information
#
# Table name: legal_page_translations
#
#  id            :bigint           not null, primary key
#  locale        :string
#  slug          :string
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  legal_page_id :integer
#
class LegalPageTranslation < ApplicationRecord
  include FriendlyIdMethods
  default_scope { order(locale: :desc) }
  has_rich_text :content

  validates_presence_of :title
  belongs_to :legal_page
end
