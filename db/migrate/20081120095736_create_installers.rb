class CreateInstallers < ActiveRecord::Migration
  def self.up
    create_table :installers do |t|
      t.references :application
      t.references :platform
      t.string :version
      t.string :installer_file_name
      t.string :installer_content_type
      t.integer :installer_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :installers
  end
end
