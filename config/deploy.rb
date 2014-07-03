require "bundler/capistrano"
require 'capistrano/ext/multistage'
require "rvm/capistrano"

# General

set :keep_releases, 5 # or any other number of releases you would like to keep
ssh_options[:port] = 2317 # if you haven't changed anything in SSH config, set it to 22
ssh_options[:forward_agent] = true # forward ssh keys
default_run_options[:pty] = true # set for the password prommpt

set :application, "awesomestickers-bootstrap" # set the name of you application here
set :user, "deploy" # and the server user name

set :stages, ["staging", "production"] # Set staging and production environment
set :default_stage, "staging" # Use staging environment as the default one to prevent accidentally deploying to production


set :deploy_via, :remote_cache # it will only fetch from the repository on server, not clone the entire repository from scratch

set :use_sudo, false # do not use sudo

# Git

set :scm, :git # set git as a Source Code Manager
set :repository,  "ssh://deploy@176.58.118.100:2317/home/#{deploy}/repos/#{awesomestickers-bootstrap}.git" # point your repository here

set :branch, "master" # set git branch here

# Server

role :web, "176.58.118.100" # HTTP Server
role :app, "176.58.118.100" # server with your app
role :db,  "176.58.118.100", :primary => true # database server
role :db,  "176.58.118.100"

# Passenger

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app do # restart your app after finalizing deployment
    run "touch #{current_path}/tmp/restart.txt"
  end
end

# Symlinking

namespace :deploy do
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml" # This file is not included repository, so we will create a symlink
  end
  task :symlink_secret_token, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb" # This file is not included repository, so we will create a symlink
  end
end

before 'deploy:assets:precompile', 'deploy:symlink_db' # callback: run this task before deploy:assets:precompile
before 'deploy:assets:precompile', 'deploy:symlink_secret_token' # # callback: run this task before deploy:assets:precompile
after "deploy", "deploy:cleanup" # delete old releases
