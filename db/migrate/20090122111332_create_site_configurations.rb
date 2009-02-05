class CreateSiteConfigurations < ActiveRecord::Migration
  def self.up
    create_table :site_configurations do |t|
      t.string :name
      t.string :header
      t.integer :root_category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :site_configurations
  end
end
