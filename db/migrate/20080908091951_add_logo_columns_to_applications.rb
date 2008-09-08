class AddLogoColumnsToApplications < ActiveRecord::Migration
  def self.up
    remove_column :applications,  :logo
    add_column :applications, :logo_file_name,    :string
    add_column :applications, :logo_content_type, :string
    add_column :applications, :logo_file_size,    :integer
    add_column :applications, :logo_updated_at,   :datetime
  end

  def self.down
    add_column :applications, :logo,   :string    
    remove_column :applications, :logo_file_name
    remove_column :applications, :logo_content_type
    remove_column :applications, :logo_file_size
    remove_column :applications, :logo_updated_at
  end
end
