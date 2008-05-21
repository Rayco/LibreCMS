class ResourcesController < ApplicationController
  before_filter :load_application
  
  # GET /resources
  # GET /resources.xml
  def index
    @resources = @application.resources.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resources }
    end
  end

  # GET /resources/1
  # GET /resources/1.xml
  def show
    @resource = @application.resources.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.xml
  def new
    @resource = @application.resources.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/1/edit
  def edit
    @resource = @application.resources.find(params[:id])
  end

  # POST /resources
  # POST /resources.xml
  def create
    @resource = @application.resources.build(params[:resource])

    respond_to do |format|
      if @resource.save
        flash[:notice] = 'Resource was successfully created.'
        format.html { redirect_to([@application, @resource]) }
        format.xml  { render :xml => @resource, :status => :created, :location => @resource }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resources/1
  # PUT /resources/1.xml
  def update
    @resource = @application.resources.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        flash[:notice] = 'Resource was successfully updated.'
        format.html { redirect_to([@application, @resource]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.xml
  def destroy
    @resource = @application.resources.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to(application_resources_url(@application)) }
      format.xml  { head :ok }
    end
  end
  
  def load_application
    @application = Application.find(params[:application_id])
  end
end
