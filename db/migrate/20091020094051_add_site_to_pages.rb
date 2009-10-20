class AddSiteToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :site, :string
  end

  def self.down
    remove_column :pages, :site
  end
end
