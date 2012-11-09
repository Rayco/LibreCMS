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

class CategoriesController < ApplicationController
  before_filter :check_administrator_role, :except => :index
  skip_before_filter :get_categories, :only => :index
  skip_before_filter :get_tags, :except => :index
  
  # GET /categories
  # GET /categories.xml
  def index
    redirect_to(edit_site_configuration_path(@site_config)) and return if @site_config.root_category.nil?

    if @tags.empty?
      @categories = @site_config.root_category.children_in_site(@site_config)
    else
      category = Category.find_with_like_by_name(String.new(@tags[-1]).from_url)
      render :file => "#{RAILS_ROOT}/public/404.html", :layout => false, :status => 404 and return if category.nil?
      @categories = category.children_in_site(@site_config)
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
    @category = Category.find_with_like_by_name(String.new(params[:id]).from_url)
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.create(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to('/configurations/categories') }
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
    @category = Category.find_with_like_by_name(String.new(params[:id]).from_url)

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to('/configurations/categories') }
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
    @category = Category.find_with_like_by_name(String.new(params[:id].from_url))
    @category.destroy

    respond_to do |format|
      flash[:notice] = 'Category was successfully destroyed.'
      format.html { redirect_to('/configurations/categories') }
      format.xml  { head :ok }
    end
  end

end
