class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title, :null => false
      t.integer :icon, :limit => 4, :null => false, :default => 0
      t.integer :sort_order
      t.integer :parent_id
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :groups, :parent_id
    add_index :groups, :user_id
  end
end
