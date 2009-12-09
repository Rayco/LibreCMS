class SiteConfiguration < ActiveRecord::Base
  # Relationships
  belongs_to :root_category, :class_name => 'Category'
  has_many :relations_in_site, :foreign_key => 'site_id', :class_name => 'MenuNode', :dependent => :destroy

  # Validates
  validates_uniqueness_of :website, :case_sensitive => false, :message => 'Ya existe'
  validates_format_of :website, :with => /^\w+([-.]\w+)*\.\w{2,}$/i
  validates_format_of :webiso, :with => /^(http[s]?:\/\/\w+([-.]\w+)*\.\w{2,}(\/\w+([-.]\w+)*)+\.iso)?$/i

end
