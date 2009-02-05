class MenuNodesController < ApplicationController
  # GET /menu_nodes
  # GET /menu_nodes.xml
  def index
    @menu_nodes = MenuNode.find(:all)

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
        format.html { redirect_to(@menu_node) }
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
      format.html { redirect_to(menu_nodes_url) }
      format.xml  { head :ok }
    end
  end
end
