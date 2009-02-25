class CategoriesController < ApplicationController
  before_filter :check_administrator_role, :except => :index
  skip_before_filter :get_categories, :only => :index
  
  # GET /categories
  # GET /categories.xml
  def index
    if params[:tags].nil?
      @tags = []
      @categories = @site_config.root_category.children_in_site
    else
      @tags = params[:tags]
      @categories = Category.find_by_name(String.new(@tags[-1]).from_url).children_in_site 
    end

    @hide = true
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find_by_name(String.new(params[:category_name]).from_url)
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.create(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to(categories_url) }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find_by_name(String.new(params[:category_name]).from_url)

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to(categories_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find_by_name(String.new(params[:tags][-1]).from_url)
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end

end
