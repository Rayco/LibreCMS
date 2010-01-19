class Page < ActiveRecord::Base
  # Validates
  validates_format_of :permalink, :with => /^\w+([-]\w+)*$/i
  validates_uniqueness_of :permalink, :case_sensitive => false, :message => 'exists'
end
