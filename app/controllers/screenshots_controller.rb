class ScreenshotsController < ApplicationController
  before_filter :check_administrator_role
  before_filter :get_application

  def index
    @screenshots = @application.screenshots.find(:all)
  end
  
  def show
    @screenshot = @application.screenshots.find(params[:id])
  end
  
  def new
    @screenshot = @application.screenshots.build #new
  end
  
  def create
    @screenshot = @application.screenshots.new(params[:screenshot])
    if @screenshot.save
      flash[:notice] = 'Screenshot was successfully created.'
      redirect_to(application_screenshots_url(@tags, @application))
    else
      render :action => 'new'
    end
  end
  
  def edit
    @screenshot = @application.screenshots.find(params[:id])
  end
  
  def update
    @screenshot = @application.screenshots.find(params[:id])
    if @screenshot.update_attributes(params[:screenshot])
      flash[:notice] = 'Screenshot was successfully updated.'
      redirect_to(application_screenshot_url(@tags, @application, @screenshot))
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @screenshot = @application.screenshots.find(params[:id])
    @screenshot.destroy
    flash[:notice] = 'Screenshot was successfully destroyed.'
    redirect_to(application_screenshots_url(@tags, @application))
  end

end
