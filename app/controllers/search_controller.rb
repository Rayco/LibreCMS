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

class SearchController < ApplicationController

  def index
    redirect_to root_path
  end

  # GET /search
  # GET /search.xml
  def create
    if params[:s].length > 1 
      params[:s] = translate(params[:s])
      params[:s] = params[:s].gsub(' ' , '%');
      @search = Application.find(:all, :conditions => ["name LIKE ? OR license LIKE ?", "%#{params[:s]}%", "%#{params[:s]}%"])
      @search += Application.find_by_sql(['select * from applications where id IN 
                                            (select taggable_id from taggings where tag_id IN 
                                              (select id from tags where name LIKE ? ))', "%#{params[:s]}%"]);
      @search += Application.find(:all, :conditions => ["description LIKE ?", "%#{params[:s]}%"])
      @search = @search.uniq
      params[:s] = params[:s].gsub('%' , ' ');
      if params[:s].match(/ /)
        param_search = params[:s].split;
	param_search.each do |p|
	  @search += Application.find(:all, :conditions => ["name LIKE ? OR license LIKE ?", "%#{p}%", "%#{p}%"])
 	  @search += Application.find_by_sql(['select * from applications where id IN 
    	    	                                  (select taggable_id from taggings where tag_id IN 
      	  	                                      (select id from tags where name LIKE ? ))', "%#{p}%"]);
    	  @search += Application.find(:all, :conditions => ["description LIKE ?", "%#{p}%"])
	  @search = @search.uniq
	end
      end
 
      if @search.size == 1
        redirect_to(application_path('search', @search))
      end
   
      @size = @search.size
      if params[:next]
 	@start = params[:end].to_i + 1
	@end = @start + 9
      elsif params[:previous]
	@start = params[:start].to_i - 10
	@end = @start + 9
      else 
	@start = 0
	@end = 9
      end
      @search =  @search[@start..@end]
    end
  end

  def translate (parameters)
    parameters = parameters.gsub('Ñ', '&ntilde;')
    parameters = parameters.gsub('Á', '&aacute;')
    parameters = parameters.gsub('É', '&eacute;')
    parameters = parameters.gsub('Í', '&iacute;')
    parameters = parameters.gsub('Ó', '&oacute;')
    parameters = parameters.gsub('Ú', '&uacute;')
    parameters = parameters.gsub('ñ', '&ntilde;')
    parameters = parameters.gsub('á', '&aacute;')
    parameters = parameters.gsub('é', '&eacute;')
    parameters = parameters.gsub('í', '&iacute;')
    parameters = parameters.gsub('ó', '&oacute;')
    parameters = parameters.gsub('ú', '&uacute;')
    return parameters
  end

end
