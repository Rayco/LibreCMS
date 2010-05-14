class SiteConfigurationsController < ApplicationController
  before_filter :check_administrator_role

  # GET /site_configurations
  # GET /site_configurations.xml
  def index
    @site_configurations = SiteConfiguration.paginate :page => params[:page], :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @site_configurations }
    end
  end

  # GET /site_configurations/1
  # GET /site_configurations/1.xml
  def show
    @site_configuration = SiteConfiguration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site_configuration }
    end
  end

  # GET /site_configurations/new
  # GET /site_configurations/new.xml
  def new
    @site_configuration = SiteConfiguration.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site_configuration }
    end
  end

  # GET /site_configurations/1/edit
  def edit
    @site_configuration = SiteConfiguration.find(params[:id])
  end

  # POST /site_configurations
  # POST /site_configurations.xml
  def create
    site = params[:site_configuration]
    site[:root_category_id] = Category.find_or_create_by_name(site[:name]).id
    @site_configuration = SiteConfiguration.new(site)

    respond_to do |format|
      if @site_configuration.save
        flash[:notice] = 'SiteConfiguration was successfully created.'
        format.html { redirect_to(@site_configuration) }
        format.xml  { render :xml => @site_configuration, :status => :created, :location => @site_configuration }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site_configuration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /site_configurations/1
  # PUT /site_configurations/1.xml
  def update
    @site_configuration = SiteConfiguration.find(params[:id])

    respond_to do |format|
      site = params[:site_configuration]
      if @site_configuration.name == "Default"
        site[:root_category_id] = Category.find_or_create_by_name(site[:name]).id
      else
        site[:root_category_id] = @site_configuration.root_category_id
      end
      if @site_configuration.update_attributes(site)
        flash[:notice] = 'SiteConfiguration was successfully updated.'
        format.html { redirect_to(@site_configuration) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site_configuration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /site_configurations/1
  # DELETE /site_configurations/1.xml
  def destroy
    @site_configuration = SiteConfiguration.find(params[:id])
    @site_configuration.destroy

    respond_to do |format|
      format.html { redirect_to(site_configurations_url) }
      format.xml  { head :ok }
    end
  end

end
