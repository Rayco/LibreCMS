require 'paperclip'
class Resource < ActiveRecord::Base
  belongs_to :application
  
  validates_presence_of :application_id
  validates_associated :application
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :application_id, :case_sensitive => false, :message => 'Ya existe'
  
  has_attached_file :resource,
                    :url => "/attached/:class/:id/:attachment/:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:basename.:extension"

end
