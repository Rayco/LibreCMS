class Permission < ActiveRecord::Base
  # Relationships
  belongs_to :user
  belongs_to :role
end
