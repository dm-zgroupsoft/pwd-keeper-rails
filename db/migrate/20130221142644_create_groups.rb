class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title, :null => false
      t.string :icon, :null => false
      t.integer :parent_id

      t.timestamps
    end

    add_index :groups, :parent_id
  end
end
