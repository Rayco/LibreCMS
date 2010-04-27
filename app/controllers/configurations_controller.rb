class ConfigurationsController < ApplicationController
  before_filter :check_administrator_role

  def index

  end

  def show
    @categories = Category.find_by_sql(['SELECT * FROM categories WHERE name NOT IN 
						(SELECT name FROM site_configurations)']);
  end

end
