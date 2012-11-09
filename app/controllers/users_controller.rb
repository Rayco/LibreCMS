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

class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  #include AuthenticatedSystem
  #before_filter :not_logged_in_required, :only => [:new, :create] 
  before_filter :login_required, :only => [:show, :edit, :update]
  before_filter :check_administrator_role, :only => [:index, :destroy, :enable, :new, :create] #new and create disable singup
  
  def index
    @users = User.find(:all)
  end
  
  #This show action only allows users to view their own profile
  def show
    @user = current_user
  end

  # render new.rhtml
  def new
    @user = User.new
  end


  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save! #old: not ! 
    # user logged in after creating an account (not recommended)
    #if @user.errors.empty?
    #  self.current_user = @user
    #  redirect_back_or_default('/')
    #  flash[:notice] = "Thanks for signing up!"
    #else
    #  render :action => 'new'
    #end
    flash[:notice] = "Thanks for signing up! Please check your email to activate your account before logging in."
    redirect_to login_path
    rescue ActiveRecord::RecordInvalid
    flash[:error] = "There was a problem creating your account."
    render :action => 'new'
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = User.find(current_user)
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated"
      redirect_to :action => 'show', :id => current_user
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.update_attribute(:enabled, false)
      flash[:notice] = "User disabled"
    else
      flash[:error] = "There was a problem disabling this user."
    end
    redirect_to :action => 'index'
  end

  def enable
    @user = User.find(params[:id])
    if @user.update_attribute(:enabled, true)
      flash[:notice] = "User enabled"
    else
      flash[:error] = "There was a problem enabling this user."
    end
      redirect_to :action => 'index'
  end
  
  #def activate
  #  self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
  #  if logged_in? && !current_user.active?
  #    current_user.activate
  #    flash[:notice] = "Signup complete!"
  #  end
  #  redirect_back_or_default('/')
  #end
  
end
