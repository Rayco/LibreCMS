require 'paperclip'

class Application < ActiveRecord::Base
  belongs_to :category
  has_many :resources, :dependent => :destroy
  
  validates_presence_of :category_id
  validates_associated :category
  
  validates_presence_of :name
  
  has_attached_file :logo, :styles => { :resized => "63x63>" }
end
