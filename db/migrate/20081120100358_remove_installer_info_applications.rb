class RemoveInstallerInfoApplications < ActiveRecord::Migration
  def self.up
    remove_column :applications, :version
    remove_column :applications, :installer_file_name
    remove_column :applications, :installer_content_type
    remove_column :applications, :installer_file_size
  end

  def self.down
    add_column :applications, :installer_file_name,    :string
    add_column :applications, :installer_content_type, :string
    add_column :applications, :installer_file_size,    :integer
    add_column :applications, :version, :string
  end
end
