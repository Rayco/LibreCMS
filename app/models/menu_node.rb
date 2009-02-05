class MenuNode < ActiveRecord::Base
  belongs_to :child, :class_name => 'Category'
  belongs_to :parent, :class_name => 'Category', :foreign_key => 'category_id'
  belongs_to :site, :class_name => 'SiteConfiguration'
end
