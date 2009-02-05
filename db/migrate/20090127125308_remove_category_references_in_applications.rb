class RemoveCategoryReferencesInApplications < ActiveRecord::Migration
  def self.up
    Application.find(:all).each do |app|
      app.update_attribute :tag_list, Category.find(app.category_id).name
    end
    remove_column :applications, :category_id
  end

  def self.down
    add_column :applications, :category_id, :integer
    Application.find(:all).each do |app|
      app.update_attribute :category_id, app.tag_list[0]
      app.update_attribute :tag_list, ""
    end
  end
end
