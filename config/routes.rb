ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'categories'

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.activate '/activate/:id', :controller => 'accounts', :action => 'show'
  map.forgot_password '/forgot_password', :controller => 'passwords', :action => 'new'
  map.reset_password '/reset_password/:id', :controller => 'passwords', :action => 'edit'
  map.change_password '/change_password', :controller => 'accounts', :action => 'update'
  map.counter '/counter', :controller => 'applications', :action => 'counter'
  map.twittear '/twittear', :controller => 'applications', :action => 'twittear'
  # map.vote_up '/vote_up', :controller => 'applications', :action => 'vote_up'
  # map.vote_down '/vote_down', :controller => 'applications', :action => 'vote_down'

  map.categories '/configurations/categories', :controller => 'configurations', :action => 'categories'
  map.applications '/configurations/applications', :controller => 'configurations', :action => 'applications'

  map.static 'static/:permalink', :controller => 'pages', :action => 'show'
  map.resources :pages
  
  map.resources :menu_nodes
  map.resources :site_configurations
  map.resources :configurations
  map.resources :search

  map.resources :users, :member => { :enable => :put } do |users|
    users.resource :account
    users.resources :roles
  end

  map.resource :session
  map.resource :password

  # See how all your routes lay out with "rake routes"
  map.resources :applications, :path_prefix => '/*tags' do |application|
    application.resources :resources
    application.resources :screenshots
    application.resources :installers
  end
  
  map.resources :ratings, :member => { :rate => :post }
  
  # http://www.myapp.com/tag1/tag2/tag3/apps/applink
  # map.applications_tagged_with '/*tags/apps', :controller => 'applications', :action => 'index'
  # map.app '/*tags/apps/:app_url', :controller => 'applications', :action => 'show'
  
  map.resources :categories
  map.categories '/*tags', :controller => 'categories', :action => 'index'
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
