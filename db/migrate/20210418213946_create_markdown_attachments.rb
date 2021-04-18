class CreateMarkdownAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :markdown_attachments do |t|
      t.string :token
      t.datetime :last_accessed_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
