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
    @applications = Application.paginate :page => params[:page], :per_page => 10
  end

end
