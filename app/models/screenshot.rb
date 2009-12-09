require 'paperclip'

class Screenshot < ActiveRecord::Base
  # Relationships  
  belongs_to :application

  # Validations
  validates_presence_of :application_id
  validates_associated :application
  
  validates_presence_of :name
  
  has_attached_file :image, :styles => { :thumb => "120x96#", :normal => "800x600>" },
                    :default_style => :normal,
                    :url => "/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:style_:basename.:extension"
                   
end
