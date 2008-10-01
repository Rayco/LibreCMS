class Category < ActiveRecord::Base
  has_many :applications, :dependent => :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  #validates_attachment_content_type :icon, :content_type => ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg']
  
  has_attached_file :icon, :styles => { :normal => "32x32", :big => "128x128" },
                    :url => "/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :default_style => :normal,
                    :default_url => "/images/defaults/:class_:attachment_:style.png"
end
