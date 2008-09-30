require 'paperclip'

class Application < ActiveRecord::Base
  belongs_to :category
  has_many :resources, :dependent => :destroy
  has_many :screenshots, :dependent => :destroy
  
  validates_presence_of :category_id
  validates_associated :category
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_attached_file :logo, :styles => { :normal => "63x63>", :small => "32x32>", :big => "128x128>" },
                    :default_style => :normal
end
