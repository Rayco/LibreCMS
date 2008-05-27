class Application < ActiveRecord::Base
  belongs_to :category
  has_many :resources, :dependent => :destroy
end
