class AddBaseTables < ActiveRecord::Migration[6.1]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    create_table :categories do |t|
      t.string :title
      t.string :slug
      t.references :language, foreign_key: true, index: true, null: false

      t.timestamps
    end

    create_table :docs do |t|
      t.string :title
      t.string :content
      t.string :slug
      t.references :category, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
