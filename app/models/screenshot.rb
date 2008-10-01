require 'paperclip'

class Screenshot < ActiveRecord::Base
  belongs_to :application
  
  validates_presence_of :application_id
  validates_associated :application
  
  validates_presence_of :name
  
  #validates_attachment_presence :shot
  #validates_attachment_content_type :shot, :content_type => ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg']

  
  has_attached_file :shot, :styles => { :thumb => "120x96#", :normal => "800x600>" },
                    :default_style => :normal,
                    :url => "/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:style_:basename.:extension"
                   
end
