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

class ConfigurationsController < ApplicationController
  before_filter :check_administrator_role

  def index

  end

  def categories
    @categories = Category.find_by_sql(['SELECT * FROM categories WHERE name NOT IN 
						(SELECT name FROM site_configurations)']);
    @categories = @categories.paginate :page => params[:page], :per_page => 10
  end

  def applications
    @applications = Application.paginate :page => params[:page], :per_page => 10, :order => "name"
  end

end
