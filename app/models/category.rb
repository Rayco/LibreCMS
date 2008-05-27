class Category < ActiveRecord::Base
  has_many :applications, :dependent => :destroy
end
