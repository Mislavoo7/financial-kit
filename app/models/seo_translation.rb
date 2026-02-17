# == Schema Information
#
# Table name: seo_translations
#
#  id          :bigint           not null, primary key
#  description :text
#  keywords    :string
#  locale      :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  seo_id      :integer
#
class SeoTranslation < ApplicationRecord
  belongs_to :seo
  default_scope { order(locale: :desc) }
end
