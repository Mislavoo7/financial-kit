# == Schema Information
#
# Table name: page_translations
#
#  id         :bigint           not null, primary key
#  locale     :string
#  slug       :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :integer
#
class PageTranslation < ApplicationRecord
  include FriendlyIdMethods
  default_scope { order(locale: :desc) }
  belongs_to :page
  validates_presence_of :title
end
