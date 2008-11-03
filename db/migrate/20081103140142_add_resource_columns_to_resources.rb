class AddResourceColumnsToResources < ActiveRecord::Migration
  def self.up
    remove_column :resources, :url
    add_column :resources, :resource_file_name,    :string
    add_column :resources, :resource_content_type, :string
    add_column :resources, :resource_file_size,    :integer
  end

  def self.down
    add_column :resources, :url, :string
    remove_column :resources, :resource_file_name
    remove_column :resources, :resource_content_type
    remove_column :resources, :resource_file_size
  end
end
