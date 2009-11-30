class Page < ActiveRecord::Base
  @site = SiteConfiguration.find(:all)

  # Validates
  $site_name = "";
  for site in @site
    $site_name += " " + site.name
  end
  validates_format_of :site, :with => /($site_name)?/i
  validates_format_of :permalink, :with => /^\w+([-]\w+)*$/i
  validates_uniqueness_of :permalink, :case_sensitive => false, :message => 'Ya existe'

end
