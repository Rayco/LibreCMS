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

class AccountsController < ApplicationController
  # Relationships
  before_filter :login_required, :except => :show
  before_filter :not_logged_in_required, :only => :show
 
  # Activate action
  def show
    # Uncomment and change paths to have user logged in after activation - not recommended
    #self.current_user = User.find_and_activate!(params[:id])
    User.find_and_activate!(params[:id])
    flash[:notice] = "Your account has been activated! You can now login."
    redirect_to login_path
    rescue User::ArgumentError
    flash[:notice] = 'Activation code not found. Please try creating a new account.'
    redirect_to new_user_path 
    rescue User::ActivationCodeNotFound
    flash[:notice] = 'Activation code not found. Please try creating a new account.'
    redirect_to new_user_path
    rescue User::AlreadyActivated
    flash[:notice] = 'Your account has already been activated. You can log in below.'
    redirect_to login_path
  end
 
  def edit
  end
  
  # Change password action  
  def update
    return unless request.post?
    if User.authenticate(current_user.login, params[:old_password])
      if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]
	if current_user.save
          flash[:notice] = "Password successfully updated."
          redirect_to root_path #profile_url(current_user.login)
        else
          flash[:notice] = "An error occured, your password was not changed."
          render :action => 'update'
        end
      else
        flash[:notice] = "New password does not match the password confirmation."
        @old_password = params[:old_password]
        render :action => 'update'      
      end
    else
      flash[:notice] = "Your old password is incorrect."
      redirect_to :action => 'update'
    end 
  end
 
end
