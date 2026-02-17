class CreateSeoTranslations < ActiveRecord::Migration[8.0]
  def change
    create_table :seo_translations do |t|
      t.string :title
      t.text :description
      t.string :keywords
      t.integer :seo_id
      t.string :locale

      t.timestamps
    end
  end
end
