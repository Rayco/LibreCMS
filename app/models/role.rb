class Role < ActiveRecord::Base
  # Relationships
  has_many :permissions
  has_many :users, :through => :permissions
end
