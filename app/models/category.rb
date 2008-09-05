class Category < ActiveRecord::Base
  has_many :applications, :dependent => :destroy
  
  validates_presence_of :name
end
