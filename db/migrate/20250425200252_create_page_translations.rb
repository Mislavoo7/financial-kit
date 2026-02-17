class CreatePageTranslations < ActiveRecord::Migration[8.0]
  def change
    create_table :page_translations do |t|
      t.string :title
      t.integer :page_id
      t.string :locale
      t.string :slug

      t.timestamps
    end
  end
end
