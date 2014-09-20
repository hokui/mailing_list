class CreateListsMembers < ActiveRecord::Migration
  def change
    create_table :lists_members, id: false do |t|
      t.integer :list_id,   null: false
      t.integer :member_id, null: false
    end

    add_index :lists_members, [:list_id, :member_id], unique: true
  end
end
