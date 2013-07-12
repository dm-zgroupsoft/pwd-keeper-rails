class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title, :null => false
      t.string :icon, :null => false
      t.string :login
      t.string :password, :null => false
      t.string :url
      t.integer :group_id, :null => false

      t.timestamps
    end

    add_index :entries, :group_id
  end
end
