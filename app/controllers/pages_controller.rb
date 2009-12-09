class PagesController < ApplicationController
  before_filter :check_administrator_role, :except => :show

  uses_tiny_mce(:options => {
   :theme => 'advanced',
   :mode => "textareas",
   :theme_advanced_toolbar_location => "top",
   :theme_advanced_toolbar_align => "left",
   :theme_advanced_resizing => true,
   :theme_advanced_resize_horizontal => false,
   :paste_auto_cleanup_on_paste => true,
   :theme_advanced_buttons1 => %w{formatselect fontselect fontsizeselect},
   :theme_advanced_buttons2 => %w{bold italic underline sub sup separator indent outdent 
                                  separator bullist numlist forecolor backcolor separator 
                                  link unlink image},
   :theme_advanced_buttons3 => [],
   :plugins => %w{contextmenu paste}},
   :only => [:new, :edit, :show, :index])
  
  def index
    @pages = Page.find(:all)
  end
  
  def show
    @hide = true
    if params[:permalink]
      @page = Page.find_by_permalink(params[:permalink])
      raise ActiveRecord::RecordNotFound, "Página no encontrada" if @page.nil?
    else
      @page = Page.find(params[:id])
    end
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = "Successfully created page."
      redirect_to @page
    else
      render :action => 'new'
    end
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = "Successfully updated page."
      redirect_to @page
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Successfully destroyed page."
    redirect_to pages_url
  end

end
