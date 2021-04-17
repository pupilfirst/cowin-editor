class AddExcerptToDocs < ActiveRecord::Migration[6.1]
  def change
    add_column :docs, :excerpt, :string
    add_reference :docs, :user, foreign_key: true
  end
end
