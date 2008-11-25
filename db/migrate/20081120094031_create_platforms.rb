class CreatePlatforms < ActiveRecord::Migration
  def self.up
    create_table :platforms do |t|
      t.string :osname
      t.string :arch
      t.string :icon_file_name
      t.string :icon_content_type
      t.integer :icon_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :platforms
  end
end
