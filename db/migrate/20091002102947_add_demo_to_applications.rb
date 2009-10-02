class AddDemoToApplications < ActiveRecord::Migration
  def self.up
    add_column :applications, :demo, :string
  end

  def self.down
    remove_column :applications, :demo
  end
end
