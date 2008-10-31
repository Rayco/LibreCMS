class AddInstallerColumnsToApplications < ActiveRecord::Migration
  def self.up
    add_column :applications, :installer_file_name,    :string
    add_column :applications, :installer_content_type, :string
    add_column :applications, :installer_file_size,    :integer
  end

  def self.down
    remove_column :applications, :installer_file_name
    remove_column :applications, :installer_content_type
    remove_column :applications, :installer_file_size
  end
end
