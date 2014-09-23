class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.integer :list_id,              null: false
      t.integer :number,               null: false
      t.string  :from,                 null: false
      t.string  :subject, default: "", null: false
      t.text    :body,    default: "", null: false
      t.text    :raw,     default: "", null: false

      t.timestamps
    end
  end
end
