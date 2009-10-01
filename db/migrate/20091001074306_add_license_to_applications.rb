class AddLicenseToApplications < ActiveRecord::Migration
  def self.up
    add_column :applications, :license, :string
  end

  def self.down
    remove_column :applications, :license
  end
end
