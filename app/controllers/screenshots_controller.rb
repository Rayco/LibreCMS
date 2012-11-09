#
#    ====================================================================
#    This file is part of LibreCMS.
#
#    Foobar is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    Foobar is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
#    ====================================================================
#

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
