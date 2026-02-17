class RemoveContentFromLegalPageTranslations < ActiveRecord::Migration[8.0]
  def change
    remove_column :legal_page_translations, :content, :text
  end
end
