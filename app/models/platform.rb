require 'paperclip'

class Platform < ActiveRecord::Base
  has_many :installers, :dependent => :destroy
  
  validates_presence_of :osname
  validates_presence_of :arch
  
  has_attached_file :icon, :styles => { :normal => "64x64", :small => "32x32" },
                    :url => "/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :default_style => :normal,
                    :default_url => "/images/defaults/:class_:attachment_:style.png"
                    
  validates_attachment_content_type :icon, :content_type => ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg']

end
