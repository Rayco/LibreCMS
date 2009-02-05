class CreateMenuNodes < ActiveRecord::Migration
  def self.up
    create_table :menu_nodes do |t|
      t.integer :category_id
      t.integer :child_id
      t.integer :site_id

      t.timestamps
    end
    
    # Content for console tests
    Category.create :name => 'WindowsLibre'
    Category.create :name => 'PYME'
    Category.create :name => 'Utilidades'
    SiteConfiguration.create :name => 'WindowsLibre', :header => 'Software Libre para windows', :root_category_id => 4
    SiteConfiguration.create :name => 'PYME', :header => 'Software Libre para empresas', :root_category_id => 5
    MenuNode.create :category_id => 4, :child_id => 1, :site_id => 1
    MenuNode.create :category_id => 4, :child_id => 3, :site_id => 1
    MenuNode.create :category_id => 4, :child_id => 2, :site_id => 1
    MenuNode.create :category_id => 1, :child_id => 2, :site_id => 1 
    MenuNode.create :category_id => 3, :child_id => 6, :site_id => 1
    MenuNode.create :category_id => 5, :child_id => 2, :site_id => 2 
    MenuNode.create :category_id => 5, :child_id => 6, :site_id => 2 
    MenuNode.create :category_id => 2, :child_id => 1, :site_id => 2 
  end

  def self.down
    drop_table :menu_nodes
  end
end
