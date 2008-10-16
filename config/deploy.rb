set :user, 'rails'
set :domain, 'mechada.osl.ull.es'
set :project, 'devrails' #'windowsLibre'
set :application, 'devrails' #'windowslibre'
set :applicationdir, "/var/www/#{application}"

# Configuracion de control de versiones
# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :scm_username, 'ancor'
set :scm_password, '17801hWg'
set :repository,  "https://svn.osl.ull.es/windowsLibre/trunk"

# Roles (servers)
role :app, "devrails.osl.ull.es"
role :web, "devrails.osl.ull.es"
role :db,  "devrails.osl.ull.es", :primary => true
#role :app, "windowsLibre.osl.ull.es"
#role :web, "windowsLibre.osl.ull.es"
#role :db,  "windowsLibre.osl.ull.es", :primary => true

# Deploy config
# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, applicationdir
set :deploy_via, :export

# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
ssh_options[:keys] = %w(~/.ssh/id_rsa)            # If you are using ssh_keys
set :chmod755, "app config db lib public vendor script script/* public/disp*"
#set :use_sudo, false   # On DreamHost's shared hosts, sudo can't be used to restart the app
