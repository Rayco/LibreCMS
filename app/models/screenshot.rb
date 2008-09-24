require 'paperclip'

class Screenshot < ActiveRecord::Base
  belongs_to :application
  
  validates_presence_of :application_id
  validates_associated :application
  
  validates_presence_of :name
  validates_presence_of :shot
  
  has_attached_file :shot, :styles => { :thumb => "120x96>", :normal => "800x600>" },
                    :default_style => :normal
end
