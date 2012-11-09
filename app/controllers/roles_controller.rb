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

class RolesController < ApplicationController
  before_filter :check_administrator_role
  
  # GET /roles
  # GET /roles.xml
  def index
    @user = User.find(params[:user_id])
    @all_roles = Role.find(:all)
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @user = User.find(params[:user_id])
    @role = Role.find(params[:id])
    unless @user.has_role?(@role.rolename)
      @user.roles << @role
    end
    redirect_to :action => 'index'
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @user = User.find(params[:user_id])
    @role = Role.find(params[:id])
    if @user.has_role?(@role.rolename)
      @user.roles.delete(@role)
    end
    redirect_to :action => 'index'
  end
  
end
