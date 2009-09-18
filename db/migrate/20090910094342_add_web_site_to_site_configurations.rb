class AddWebSiteToSiteConfigurations < ActiveRecord::Migration
  def self.up
    add_column :site_configurations, :website, :string
  end

  def self.down
    remove_column :site_configurations, :website
  end
end
