require 'paperclip'

class Installer < ActiveRecord::Base
  belongs_to :application
  belongs_to :platform
  
  validates_presence_of :application_id
  validates_associated :application
  
  validates_presence_of :platform_id
  validates_associated :platform
  
  has_attached_file :installer,
                    :url => "/attached/:class/:id/:attachment/:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:basename.:extension"
                    
  validates_attachment_presence :installer

end
