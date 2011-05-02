# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :get_site_configuration, :get_pages, :get_tags, :prepare_cloud, :get_new_apps, :get_update_apps, :get_downloads #, :get_categories
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'a8cd8350fd7769a825b7fc67f19a29de'
  
  private
  
  def get_new_apps
    @new_apps = Array.new
    Application.find(:all, :order => "created_at DESC").each do |app|
      $good = 0
      app.tag_list.each do |tag|
        if c = Category.find_by_name(tag)
          if !MenuNode.find(:first, :conditions => ["child_id LIKE ? AND site_id LIKE ?", c.id, $site_id]).nil?
            $good = 1
            break
          end
        end
      end
      @new_apps << app if $good == 1
      break if @new_apps.size == 5
    end
  end

  def get_update_apps
    @update_apps = Array.new
    @apps = Array.new
    app = Struct.new(:app, :date)
    Application.find(:all, :joins => :installers, :order => "installers.updated_at DESC").uniq.each do |application|
      $good = 0
      application.tag_list.each do |tag|
        if c = Category.find_by_name(tag)
          if !MenuNode.find(:first, :conditions => ["child_id LIKE ? AND site_id LIKE ?", c.id, $site_id]).nil?
            $good = 1
            break
          end
        end 
      end
      @apps << application if $good == 1
      break if @apps.size == 5
    end
    @apps.each do |i|
      @update_apps << app.new(i, Installer.find(:last, :conditions => ["application_id LIKE ?", "%#{i.id}%"]).updated_at)
    end
  end

  def get_downloads
    @downloads = Array.new
    app = Struct.new(:pos, :app, :value)
    Download.all.each do |counter|
      application = Application.find_by_id(counter.application_id)
      $good = 0
      if !application.nil?
        application.tag_list.each do |tag|
          if c = Category.find_by_name(tag)
            if !MenuNode.find(:first, :conditions => ["child_id LIKE ? AND site_id LIKE ?", c.id, $site_id]).nil?
              $good = 1
              break
            end
          end
        end
      end
      @downloads << app.new(1, counter.application_id, counter.windows + counter.linux + counter.mac + counter.multiplatform) if $good == 1
    end
    @downloads = @downloads.sort {|x, y| y.value <=> x.value }
    @downloads = @downloads[0..19]
    $i = 1
    @downloads.each do |counter|
      counter.pos = $i
      $i += 1
    end
    if params[:controller] != 'pages'
      @downloads = @downloads.paginate :page => params[:page], :per_page => 5
    end
  end

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
    @cloud_site = []
    Application.all.each do |app|
      $good = 0
      app.tag_counts.each do |tag|
        if c = Category.find_by_name(tag.name)
          if !MenuNode.find(:first, :conditions => ["child_id LIKE ? AND site_id LIKE ?", c.id, $site_id]).nil?
            $good = 1
            break
          end
        end
      end
      @cloud_site << app.tag_counts if $good == 1
    end
    @cloud_site = @cloud_site.flatten.uniq.sort { |x, y| x.name <=> y.name }
    
    @cloud = Application.tag_counts.sort { |x, y| x.name <=> y.name }
    @css_classes = (1 .. 6).map { |i| "tag#{i}" }
  end

end
