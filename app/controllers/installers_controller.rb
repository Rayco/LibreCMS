class InstallersController < ApplicationController
  before_filter :check_administrator_role
  before_filter :get_application

  def index
    @installers = @application.installers.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @installers }
    end
  end

  def show
    @installer = @application.installers.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @installer }
    end
  end

  def new
    @installer = @application.installers.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @installer }
    end
  end

  def edit
    @installer = @application.installers.find(params[:id])
  end

  def create
    @installer = @application.installers.new(params[:installer])

    respond_to do |format|
      if @installer.save
        flash[:notice] = 'Installer was successfully created.'
        format.html { redirect_to(application_installers_url(@tags, @application)) }
        format.xml  { render :xml => @installer, :status => :created, :location => @installer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @installer.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @installer = @application.installers.find(params[:id])

    respond_to do |format|
      if @installer.update_attributes(params[:installer])
        flash[:notice] = 'Installer was successfully updated.'
        format.html { redirect_to(application_installer_url(@tags, @application, @installer)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @installer.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @installer = @application.installers.find(params[:id])
    @installer.destroy
    
    respond_to do |format|
      flash[:notice] = "Successfully destroyed installer."
      format.html { redirect_to(application_installers_url(@tags, @application)) }
      format.xml  { head :ok }
    end
  end

end
