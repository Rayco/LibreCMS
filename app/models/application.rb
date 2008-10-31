require 'paperclip'

class Application < ActiveRecord::Base
  belongs_to :category
  has_many :resources, :dependent => :destroy
  has_many :screenshots, :dependent => :destroy
  
  validates_presence_of :category_id
  validates_associated :category
  
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false, :message => 'Ya existe'
  
  has_attached_file :logo, :styles => { :normal => "63x63", :small => "32x32", :big => "128x128" },
                    :url => "/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :default_style => :normal,
                    :default_url => "/images/defaults/:class_:attachment_:style.png"
                    
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg']
  
  has_attached_file :installer,
                    :url => "/attached/:class/:id/:attachment/:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:basename.:extension",
                    :default_url => "/images/defaults/:class_:attachment.png"
  
end
