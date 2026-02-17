class CreateSectionTranslations < ActiveRecord::Migration[8.0]
  def change
    create_table :section_translations do |t|
      t.string :title
      t.integer :section_id
      t.string :locale

      t.timestamps
    end
  end
end
