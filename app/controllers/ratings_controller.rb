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

class RatingsController < ApplicationController

  before_filter :get_class_by_name

  def rate
    @ip = request.remote_ip
    rateable = @rateable_class.find(params[:id])
    # Delete the old ratings for same IP
    Rating.delete_all(["rateable_type = ? AND rateable_id = ? AND user_ip = ?", @rateable_class.base_class.to_s, params[:id], @ip])
    rating = Rating.new(:rating => params[:rating], :user_ip => @ip)
    rateable.ratings << rating
    rateable.save

    render :update do |page|
      page.replace_html "star-ratings-block", :partial => "ratings/rate", :locals => { :asset => rateable }
      #page.visual_effect :highlight, "star-ratings-block"
    end
  end

  protected

  # Gets the rateable class based on the params[:rateable_type]
  def get_class_by_name
    bad_class = false
    begin
      @rateable_class = Module.const_get(params[:rateable_type])
    rescue NameError
      bad_class = true
    end

    if bad_class
      redirect_to home_url
    return false
    
    end
    true
  end

end
