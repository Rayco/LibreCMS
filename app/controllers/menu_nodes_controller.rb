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

class MenuNodesController < ApplicationController
  before_filter :check_administrator_role

  # GET /menu_nodes
  # GET /menu_nodes.xml
  def index
    @menu_nodes = MenuNode.paginate :page => params[:page], :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menu_nodes }
    end
  end

  # GET /menu_nodes/1
  # GET /menu_nodes/1.xml
  def show
    @menu_node = MenuNode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @menu_node }
    end
  end

  # GET /menu_nodes/new
  # GET /menu_nodes/new.xml
  def new
    @menu_node = MenuNode.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @menu_node }
    end
  end

  # GET /menu_nodes/1/edit
  def edit
    @menu_node = MenuNode.find(params[:id])
  end

  # POST /menu_nodes
  # POST /menu_nodes.xml
  def create
    @menu_node = MenuNode.new(params[:menu_node])

    respond_to do |format|
      if @menu_node.save
        flash[:notice] = 'MenuNode was successfully created.'
        format.html { redirect_to :action => "index"}
        format.xml  { render :xml => @menu_node, :status => :created, :location => @menu_node }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menu_node.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /menu_nodes/1
  # PUT /menu_nodes/1.xml
  def update
    @menu_node = MenuNode.find(params[:id])

    respond_to do |format|
      if @menu_node.update_attributes(params[:menu_node])
        flash[:notice] = 'MenuNode was successfully updated.'
        format.html { redirect_to(@menu_node) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu_node.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_nodes/1
  # DELETE /menu_nodes/1.xml
  def destroy
    @menu_node = MenuNode.find(params[:id])
    @menu_node.destroy

    respond_to do |format|
      flash[:notice] = 'MenuNode was successfully destroyed.'
      format.html { redirect_to(menu_nodes_url) }
      format.xml  { head :ok }
    end
  end
end
