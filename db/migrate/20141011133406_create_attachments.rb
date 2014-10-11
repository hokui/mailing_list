class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :archive_id,     null: false
      t.string  :name,           null: false
      t.string  :type,           null: false
      t.text    :content_base64, null: false

      t.timestamps
    end

    add_index :attachments, :archive_id
  end
end
