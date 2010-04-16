class AddLicenseUrlToApplications < ActiveRecord::Migration
  def self.up
    add_column :applications, :license_url, :string
  end

  def self.down
    remove_column :applications, :license_url
  end
end
