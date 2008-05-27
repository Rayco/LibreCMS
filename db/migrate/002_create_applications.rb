class CreateApplications < ActiveRecord::Migration
  def self.up
    create_table :applications do |t|
      t.references :category
      t.string :name
      t.string :logo
      t.string :website
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :applications
  end
end
