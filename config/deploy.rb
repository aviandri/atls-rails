require "bundler/capistrano"

server "106.187.49.7", :web, :app, :db, :primary => true

set :application, "atls"
set :user "aviandri"
set deploy_to, "home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo :false

set :scm, "git"
set :repository,  "git@github.com:aviandri/atls-rails.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "your app-server here"                          # This may be the same as your `Web` server
role :db,  "your primary db-server her
role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end