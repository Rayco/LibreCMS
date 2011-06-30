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
