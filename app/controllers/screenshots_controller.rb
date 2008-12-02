class ScreenshotsController < ApplicationController
  before_filter :check_administrator_role
  before_filter :get_category
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
      flash[:notice] = "Successfully created screenshot."
      redirect_to(category_application_screenshots_url(@category, @application))
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
      flash[:notice] = "Successfully updated screenshot."
      redirect_to(category_application_screenshot_url(@category, @application, @screenshot))
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @screenshot = @application.screenshots.find(params[:id])
    @screenshot.destroy
    flash[:notice] = "Successfully destroyed screenshot."
    redirect_to(category_application_screenshots_url(@category, @application))
  end
end
