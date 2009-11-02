class AddCodeToSiteConfigurations < ActiveRecord::Migration
  def self.up
    add_column :site_configurations, :code, :string
  end

  def self.down
    remove_column :site_configurations, :code
  end
end
