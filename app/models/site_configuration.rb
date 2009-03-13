class SiteConfiguration < ActiveRecord::Base
  belongs_to :root_category, :class_name => 'Category'
  has_many :relations_in_site, :foreign_key => 'site_id', :class_name => 'MenuNode', :dependent => :destroy
  # need another relations with categories through MenuNode?
end
