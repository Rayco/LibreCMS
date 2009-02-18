require 'paperclip'

class Category < ActiveRecord::Base
  # Relationships
  has_many :site_configurations, :foreign_key => "root_category_id"
   
  has_many :category_as_child, :foreign_key => 'child_id', :class_name => 'MenuNode', :dependent => :destroy
  has_many :category_as_parent, :foreign_key => 'category_id', :class_name => 'MenuNode', :dependent => :destroy
  has_many :parents, :through => :category_as_child, :order => 'name'
  has_many :children, :through => :category_as_parent,  :order => 'name'
    
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false, :message => 'Ya existe'
  
  has_attached_file :icon, :styles => { :normal => "32x32", :big => "128x128", :small => "16x16" },
                    :url => "/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :default_style => :normal,
                    :default_url => "/images/defaults/:class_:attachment_:style.png"
                    
  validates_attachment_content_type :icon, :content_type => ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg']
  
  def children_in_site
    children = []
    self.category_as_parent.each do |relation|
      children << relation.child if relation.site_id == 1 # @site_config.id
    end
    return children.sort {|x,y| x.name <=> y.name }
  end
  
  def to_param
    cat_url = String.new(name)
    "#{cat_url.to_url}"
  end
end
