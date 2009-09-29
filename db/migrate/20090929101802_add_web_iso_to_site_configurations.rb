class AddWebIsoToSiteConfigurations < ActiveRecord::Migration
  def self.up
    add_column :site_configurations, :webiso, :string
  end

  def self.down
    remove_column :site_configurations, :webiso
  end
end
