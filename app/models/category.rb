require 'paperclip'

class Category < ActiveRecord::Base
  # Relationships
  has_many :site_configurations, :foreign_key => "root_category_id"
   
  has_many :category_as_child, :foreign_key => 'child_id', :class_name => 'MenuNode', :dependent => :destroy
  has_many :category_as_parent, :foreign_key => 'category_id', :class_name => 'MenuNode', :dependent => :destroy
  has_many :parents, :through => :category_as_child, :order => 'name'
  has_many :children, :through => :category_as_parent,  :order => 'name'
    
  # Validations
  validates_presence_of :name, :message => 'of the Permanent Link is invalid'
  validates_uniqueness_of :name, :case_sensitive => false, :message => 'of the Permanent already exists'
  
  has_attached_file :icon, :styles => { :normal => "32x32", :big => "128x128", :small => "16x16" },
                    :url => "/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :default_style => :normal,
                    :default_url => "/images/defaults/:class_:attachment_:style.png"
                    
  validates_attachment_content_type :icon, :content_type => ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg']

  def children_in_site(site_config)
    children = []
    self.category_as_parent.each do |relation|
      children << relation.child if relation.site_id == site_config.id
    end
    return children.sort {|x,y| x.name.downcase <=> y.name.downcase }
  end

  def parents_in_site(site_config)
    parents = []
    site_config.each do |site|
      self.category_as_child.each do |relation|
        parents << relation.parent.name if relation.site_id == SiteConfiguration.find_by_name(site).id
      end
    end
    parents = parents.flatten.uniq.join(', ')
    return parents.sort {|x,y| x.downcase <=> y.downcase }
  end

  def relationship_in_site?(site_id, parent_id)
    !MenuNode.find(:first, :conditions => ["site_id = ? AND category_id = ? AND child_id = ?", site_id, parent_id, self.id]).nil?
  end
  
  def to_param
    unless name.nil?
      cat_url = String.new(name)
      "#{cat_url.to_url}"
    end
  end

  def parents_names
    self.parents_in_site(SiteConfiguration.find(:all).map(&:name))
  end

  def parents_names=(parents_name)
    MenuNode.find(:all, :conditions => ["child_id = ?", self.id]).each do |node|
      if !parents_name.member?(Category.find_by_id(node.category_id).name)
        node.destroy
      end
    end
    parents_name.split(",").each do |p|
      parent = Category.find_or_create_by_name(p.strip, :conditions => ["name LIKE ?", p.strip])
      if !SiteConfiguration.find_by_name(p.strip).nil?
        site = SiteConfiguration.find_by_name(p.strip).id
        category_as_child.build(:category_id => parent.id, :child_id => self.id, :site_id => site) unless relationship_in_site?(site, parent.id)
      else  
        category_as_child.build(:category_id => parent.id, :child_id => self.id, :site_id => $site_id) unless relationship_in_site?($site_id, parent.id)
      end
    end
  end

  def self.find_with_like_by_name(name)
    find(:first, :conditions => ["name LIKE ?", name])
  end

end
