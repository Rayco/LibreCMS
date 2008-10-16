load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

desc "Link shared files"
task :before_symlink do
  run "rm -drf #{release_path}/public/attached"
  run "ln -s #{shared_path}/attached #{release_path}/public/attached"
end

