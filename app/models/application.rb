require 'paperclip'

class Application < ActiveRecord::Base
  has_many :resources, :dependent => :destroy
  has_many :screenshots, :dependent => :destroy
  has_many :installers, :dependent => :destroy
  
  acts_as_taggable_on :tags
  
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false, :message => 'Ya existe'
  
  has_attached_file :logo, :styles => { :normal => "63x63", :small => "32x32", :big => "128x128" },
                    :url => "/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :default_style => :normal,
                    :default_url => "/images/defaults/:class_:attachment_:style.png"
                    
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg']


  def self.find_by_tags(tags)    
    applications = Application.tagged_with(tags.join(", "), :on => :tags)
    for tag in tags
      apps_on_tag = Application.tagged_with(tag, :on => :tags)
      applications = applications & apps_on_tag 
    end
    applications.sort { | a,b | a.name.downcase <=> b.name.downcase }
  end

  def to_param
    unless name.nil?
      app_url = String.new(name)
      "#{app_url.to_url}"
    end
  end
end
