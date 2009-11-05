class UpCodeToSiteConfigurations < ActiveRecord::Migration
  def self.up
    change_column :site_configurations, :code, :text
  end

  def self.down
    change_column :site_configurations, :code, :string
  end
end
