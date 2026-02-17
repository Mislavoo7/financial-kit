class CreateLegalPageTranslations < ActiveRecord::Migration[8.0]
  def change
    create_table :legal_page_translations do |t|
      t.string :title
      t.text :content
      t.string :locale
      t.integer :legal_page_id
      t.string :slug

      t.timestamps
    end
  end
end
