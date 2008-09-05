class Resource < ActiveRecord::Base
  belongs_to :application
  
  validates_presence_of :application_id
  validates_associated :application
  
  validates_presence_of :name
  validates_presence_of :url
end
