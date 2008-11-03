class AddMoreInfoToApplications < ActiveRecord::Migration
  def self.up
    add_column :applications, :version, :string
    add_column :applications, :user_upload, :integer
    add_column :applications, :user_recommend, :integer
    add_column :applications, :user_valuation, :float
  end

  def self.down
    remove_column :applications, :version
    remove_column :applications, :user_upload
    remove_column :applications, :user_recommend
    remove_column :applications, :user_valuation
  end
end
