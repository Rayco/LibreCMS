class ApplicationsController < ApplicationController
  before_filter :check_administrator_role, :except => [:show, :index, :counter, :vote_up, :vote_down]

  uses_tiny_mce(:options => {
   :theme => 'advanced',
   :mode => "textareas",
   :theme_advanced_toolbar_location => "top",
   :theme_advanced_toolbar_align => "left",
   :theme_advanced_resizing => true,
   :theme_advanced_resize_horizontal => false,
   :paste_auto_cleanup_on_paste => true,
   :theme_advanced_buttons1 => %w{bold italic underline sub sup separator justifyleft 
                                  justifycenter justifyright justifyfull indent outdent 
                                  separator bullist numlist forecolor backcolor separator 
                                  link unlink},
   :theme_advanced_buttons2 => [],
   :theme_advanced_buttons3 => [],
   :plugins => %w{contextmenu paste}},
   :only => [:new, :edit, :show, :index])
  
  # GET /applications
  # GET /applications.xml
  def index
    @applications = Application.tagged_with(@tags.join(", "), :on => :tags, :match_all => true).sort { |x, y| x.name.downcase <=> y.name.downcase }
    @applications = @applications.paginate :page => params[:page], :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.xml
  def show
    @application = Application.find_with_like_by_name(params[:id].from_url)
    @win32 = @application.installers.tagged_with("Windows, 32bits", :on => :platforms, :match_all => true).flatten 
    @win64 = @application.installers.tagged_with("Windows, 64bits", :on => :platforms, :match_all => true).flatten
    @linux = @application.installers.tagged_with("Linux", :on => :platforms, :match_all => true).flatten
    @mac = @application.installers.tagged_with("Mac", :on => :platforms, :match_all => true).flatten
    @multiplatform = @application.installers.tagged_with("Multiplatform", :on => :platforms, :match_all => true).flatten
    @screenshots = @application.screenshots
    @last_update = Installer.find(:last, :conditions => ["application_id LIKE ?", "%#{@application.id}%"])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @application }
    end
  end

  # GET /applications/new
  # GET /applications/new.xml
  def new
    @application = Application.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @application }
    end
  end

  # GET /applications/1/edit
  def edit
    @application = Application.find_with_like_by_name(params[:id].from_url)
  end

  # POST /applications
  # POST /applications.xml
  def create
    @application = Application.new(params[:application])

    respond_to do |format|
      if @application.save
	require 'open-uri'
        begin
          @url_app = @site_config.website + application_path(@tags, @application)
          @url_app = @url_app.gsub('Ñ', 'N;')
          @url_app = @url_app.gsub('Á', 'A;')
          @url_app = @url_app.gsub('É', 'E')
          @url_app = @url_app.gsub('Í', 'I')
          @url_app = @url_app.gsub('Ó', 'O')
          @url_app = @url_app.gsub('Ú', 'U')
          @url_app = @url_app.gsub('ñ', 'n')
          @url_app = @url_app.gsub('á', 'a')
          @url_app = @url_app.gsub('é', 'e')
          @url_app = @url_app.gsub('í', 'i')
          @url_app = @url_app.gsub('ó', 'o')
          @url_app = @url_app.gsub('ú', 'u')

          f = open('http://t.osl.ull.es/url/' + @url_app + '?out=1')
          @url = f.read
          client = Twitter::Client.new
          client.update("[New] #" + @application.name + " ya disponible en http://" + @url)
	rescue
          false
        end
        flash[:notice] = 'Application was successfully created.'
        format.html { redirect_to(application_path(@tags, @application)) }
        format.xml  { render :xml => @application, :status => :created, :location => @application }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @application.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /applications/1
  # PUT /applications/1.xml
  def update
    @application = Application.find_with_like_by_name(params[:id].from_url)

    respond_to do |format|
      if @application.update_attributes(params[:application])
        flash[:notice] = 'Application was successfully updated.'
        format.html { redirect_to(application_path(@tags, @application)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @application.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.xml
  def destroy
    @application = Application.find_with_like_by_name(params[:id].from_url)
    @application.destroy
    
    respond_to do |format|
      flash[:notice] = 'Application was successfully destroyed.'
      format.html { redirect_to(applications_url(@tags)) }
      format.xml  { head :ok }
    end
  end

  def counter
    if Download.find_by_application_id(params[:id]).nil?
      @download = Download.new(:application_id => params[:id])
      @download.save
    end
    @download = Download.find_by_application_id(params[:id])
    case params[:platform]
      when "windows"
	@download.windows += 1;
      when "linux"
	@download.linux += 1;
      when "mac"
	@download.mac += 1;
      when "multiplatform"
	@download.multiplatform += 1;
    end
    @download.save
    render :nothing => true, :status => 200
  end

  def vote_up
    @ip = request.remote_ip
    @application = Application.find_by_id(params[:id])
    if Votes.find(:first, :conditions => {:application_id => @application.id, :ip_address => @ip }).nil?
      @application.vote_up += 1;
      @application.save
      render(:update) { |page| page.call 'location.reload' }
      @votes = Votes.new(:application_id => @application.id, :ip_address => @ip)
      @votes.save
    else
      render :nothing => true, :status => 200
    end
  end

  def vote_down
    @ip = request.remote_ip
    @application = Application.find_by_id(params[:id])
    if Votes.find(:first, :conditions => {:application_id => @application.id, :ip_address => @ip }).nil?
      @application = Application.find_by_id(params[:id])
      @application.vote_down += 1;
      @application.save
      render(:update) { |page| page.call 'location.reload' }
      @votes = Votes.new(:application_id => @application.id, :ip_address => @ip)
      @votes.save
    else
      render :nothing => true, :status => 200
    end
  end

  def twittear
    begin
      msg = "" + params[:message]
      client = Twitter::Client.new
      client.update(msg)
    rescue
      false
    end
    render :nothing => true, :status => 200
  end

end
