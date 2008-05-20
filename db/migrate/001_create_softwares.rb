class CreateSoftwares < ActiveRecord::Migration
  def self.up
    create_table :softwares do |t|
      t.string :name
      t.string :logo
      t.string :website
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :softwares
  end
end
