class ApplicationsController < ApplicationController
  before_filter :check_administrator_role, :except => [:show, :index]
  
  # GET /applications
  # GET /applications.xml
  def index
    @tags = params[:tags]
    @applications = Application.find_by_tags(params[:tags])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.xml
  def show
    @tags = params[:tags]
    @application = Application.find_by_name(params[:id].from_url)
    @screenshots = @application.screenshots.paginate :per_page => 1, :page => params[:page]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @application }
    end
  end

  # GET /applications/new
  # GET /applications/new.xml
  def new
    @tags = params[:tags]
    @application = Application.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @application }
    end
  end

  # GET /applications/1/edit
  def edit
    @application = Application.find_by_name(params[:id].from_url)
  end

  # POST /applications
  # POST /applications.xml
  def create
    @tags = params[:tags]
    @application = Application.build(params[:application])

    respond_to do |format|
      if @application.save
        flash[:notice] = 'Application was successfully created.'
        format.html { redirect_to(application_path(@tags, @application)) }
        format.xml  { render :xml => @application, :status => :created, :location => @application }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @application.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /applications/1
  # PUT /applications/1.xml
  def update
    @tags = params[:tags]
    @application = Application.find_by_name(params[:id].from_url)

    respond_to do |format|
      if @application.update_attributes(params[:application])
        flash[:notice] = 'Application was successfully updated.'
        format.html { redirect_to(application_path(@tags, @application)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @application.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.xml
  def destroy
    @tags = params[:tags]
    @application = Application.find_by_name(params[:id].from_url)
    @application.destroy

    respond_to do |format|
      format.html { redirect_to(applications_url) }
      format.xml  { head :ok }
    end
  end
end
