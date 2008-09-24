# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :get_categories
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'a8cd8350fd7769a825b7fc67f19a29de'
  
  private
  def get_categories
    @categories = Category.find(:all)
  end
  
  def get_category
    @category = Category.find(params[:category_id])
  end
  
  def get_application
    @application = Category.find(params[:category_id]).applications.find(params[:application_id])
  end
  
end
