class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :archive_id,     null: false
      t.string  :name,           null: false
      t.string  :mime,           null: false
      t.boolean :is_image
      t.text    :content_base64, null: false

      t.timestamps
    end

    add_index :attachments, :archive_id
  end
end
