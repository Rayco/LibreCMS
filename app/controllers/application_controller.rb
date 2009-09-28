# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :get_site_configuration, :get_pages, :get_tags, :prepare_cloud #, :get_categories
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'a8cd8350fd7769a825b7fc67f19a29de'
  
  private
  #def get_categories
  #  @categories = @site_config.root_category.children_in_site
  #end
  
  def get_application
    @application = Application.find_by_name(params[:application_id].from_url)
  end
  
  def get_pages
    @pages = Page.find(:all, :order => 'name')
  end
  
  def get_site_configuration
    dominio = request.subdomains.join(".") + "." + request.domain if !request.domain.nil?
    dominio = request.domain if request.subdomains.join(".") == ""
    @site_config = SiteConfiguration.find_by_website(dominio)
    if @site_config.nil?
      @site_config = SiteConfiguration.find(:first)
      $site_id = 1
    else
      $site_id = @site_config.id
    end
  end
  
  def get_tags
    @tags = params[:tags]
    @tags = [] if @tags.nil?
  end

  def prepare_cloud
    @cloud = Application.tag_counts.sort { |x, y| x.name <=> y.name }
    @css_classes = (1 .. 6).map { |i| "tag#{i}" }
  end
end
