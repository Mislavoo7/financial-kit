class AddUrlToSeoTranslation < ActiveRecord::Migration[8.0]
  def change
    add_column :seo_translations, :url, :string
  end
end
