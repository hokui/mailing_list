class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name,                   null: false
      t.string :email,                  null: false
      t.string :email_sub, default: "", null: false

      t.timestamps
    end

    add_index :members, :email, unique: true
    add_index :members, :email_sub
  end
end
