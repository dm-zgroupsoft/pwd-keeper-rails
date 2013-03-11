class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title, :null => false
      t.string :icon, :null => false
      t.integer :position, :null => false, :default => 0
      t.integer :group_id
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :groups, :group_id
    add_index :groups, :user_id
  end
end
