class AddPublicNameToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :publicname, :string
  end

  def self.down
    remove_column :categories, :publicname
  end
end
