class SearchController < ApplicationController

  def index
    redirect_to root_path
  end

  # GET /search
  # GET /search.xml
  def create
    @search = Application.find(:all, :conditions => ["name LIKE ? OR license LIKE ?", "%#{params[:s]}%", "%#{params[:s]}%"])
    @search += Application.find_by_sql(['select * from applications where id IN 
						(select taggable_id from taggings where tag_id LIKE 
							(select id from tags where name LIKE ? ))', "%#{params[:s]}%"]);
    @search += Application.find(:all, :conditions => ["description LIKE ?", "%#{params[:s]}%"])
    @search = @search.uniq
  end

  def show
    redirect_to root_path 
  end

end
