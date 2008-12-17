require 'paperclip'

class Installer < ActiveRecord::Base
  belongs_to :application
  
  validates_presence_of :application_id
  validates_associated :application
  
  has_attached_file :installer,
                    :url => "/attached/:class/:id/:attachment/:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:basename.:extension"
                    
  validates_attachment_presence :installer

end
