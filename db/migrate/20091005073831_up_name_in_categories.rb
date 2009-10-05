class UpNameInCategories < ActiveRecord::Migration
  def self.up
    change_column :categories, :name, :string, :limit => 40, :null => false 
  end

  def self.down
    change_column :categories, :name, :string, :limit => 20, :null => false
  end
end
