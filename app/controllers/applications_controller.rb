class ApplicationsController < ApplicationController
  before_filter :get_category
  before_filter :get_all_categories
  
  # GET /applications
  # GET /applications.xml
  def index
    @applications = @category.applications.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.xml
  def show
    @application = @category.applications.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @application }
    end
  end

  # GET /applications/new
  # GET /applications/new.xml
  def new
    @application = @category.applications.build #build or new?

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @application }
    end
  end

  # GET /applications/1/edit
  def edit
    @application = @category.applications.find(params[:id])
  end

  # POST /applications
  # POST /applications.xml
  def create
    @application = @category.applications.build(params[:application]) #build or new?

    respond_to do |format|
      if @application.save
        flash[:notice] = 'Application was successfully created.'
        format.html { redirect_to([@category, @application]) }
        #format.hml { redirect_to(@category) }
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
    @application = @category.applications.find(params[:id])

    respond_to do |format|
      if @application.update_attributes(params[:application])
        flash[:notice] = 'Application was successfully updated.'
        format.html { redirect_to([@category, @application]) }
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
    @application = @category.applications.find(params[:id])
    @application.destroy

    respond_to do |format|
      format.html { redirect_to(category_applications_url(@category)) }
      format.xml  { head :ok }
    end
  end
  
  private
  def get_category
    @category = Category.find(params[:category_id])
  end
  
  def get_all_categories
    @categories = Category.find(:all)
  end
end
