class AddWebsiteToResources < ActiveRecord::Migration
  def self.up
    add_column :resources, :website, :string
  end

  def self.down
    remove_column :resources, :website
  end
end
