class SearchController < ApplicationController

  def index
    redirect_to root_path
  end

  # GET /search
  # GET /search.xml
  def create
    if params[:s].length > 1 
      params[:s] = translate(params[:s])
      @search = Application.find(:all, :conditions => ["name LIKE ? OR license LIKE ?", "%#{params[:s]}%", "%#{params[:s]}%"])
      @search += Application.find_by_sql(['select * from applications where id IN 
                                            (select taggable_id from taggings where tag_id IN 
                                              (select id from tags where name LIKE ? ))', "%#{params[:s]}%"]);
      @search += Application.find(:all, :conditions => ["description LIKE ?", "%#{params[:s]}%"])
      @search = @search.uniq
    end
  end

  def show
    redirect_to root_path 
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
