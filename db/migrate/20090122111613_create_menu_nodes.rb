class CreateMenuNodes < ActiveRecord::Migration
  def self.up
    create_table :menu_nodes do |t|
      t.integer :category_id
      t.integer :child_id
      t.integer :site_id

      t.timestamps
    end
  end

  def self.down
    drop_table :menu_nodes
  end
end
