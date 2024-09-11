---
layout: post
title: "Capistrano Without Root Privileges"
date: 2015-01-29
categories: 
  - "ruby-on-rails"
  - "software-development"
---

Given a user with sudo (but not root) access on a remote box, the following deploy.rb script will perform a capistrano deploy of a ruby application:

Assumptions:

1. You’re using ‘git’. Although svn can be used, the script targets a git setup.
    
2. You’re using mongrel\_cluster. Change the script accordingly if using passenger etc.
    
3. The application being deployed is dropped into a subfolder/subdirectory on the remote server. You can remove the task :recreate\_public\_link if you’re deploying to the root of a virtual directory.
    
4. A user and group called ‘mongrel’ has been created on the remote server. This owns the running mongrel\_cluster processes. Relevant permissions are set by the script.
    
    ```
    #-----------------------------------------------------
    # deploy.rb - controls deployment setup/configuration
    # using the capistrano or 'cap' deployment utility.
    #-----------------------------------------------------
    
    requires mongrel_cluster recipes to allow restart of mongrel cluster
    require 'mongrel_cluster/recipes'
    
    set :application, "[application name]"
    set :user, "peter"
    set :web_user, "apache"
    set :location, "[ip address]"
    #If you are using Passenger mod_rails uncomment the following block:
    #if you're still using the script/reapear helper you will need these
    # http://github.com/rails/irs_process_scripts
    
    namespace :deploy do
    
    task :start do ; end
    task :stop do ; end
    
    task :restart, :roles => :app, :except => { :no_release => true } do
        run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    end
    end
    
    ssh_options[:forward_agent] = true
    
    default_run_options[:pty] = true
    set :scm, "git"
    set :scm_user, "git"
    set :repository, "#{scm_user}@#{location}:/usr/local/share/gitrepos/#{application}.git"
    set :scm_passphrase, "your password" #This is your custom users password
    set :git_shallow_clone, 1
    set :deploy_via, :remote_cache
    set :branch, "master"
    set :use_sudo, true
    set :site_root, "app/[application name]"
    role :app, location
    role :web, location
    role :db, location, :primary=>true
    set :deploy_to, "/var/www/html/[your test site url]/#{application}"
    #--------------
    
    mongrel details
    
    #--------------
    
    set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"
    set :mongrel_user, "mongrel"
    set :mongrel_group, "mongrel"
    set :runner, nil
    set :mongrel_clean, true # helps keep mongrel pid files clean
    
    #----------------------
    
    migration parameters
    
    #---------------------
    
    set :rake, "rake"
    set :rails_env, "production"
    set :migrate_env, ""
    set :migrate_target, :latest
    
    before "deploy:update_code", "custom:set_permissions_for_checkout"
    before "deploy:migrate", "custom:set_permissions_pre_schema_dump"
    after "deploy:migrate", "custom:set_permissions_post_schema_dump"
    
    before "deploy:migrations", "custom:set_permissions_pre_schema_dump"
    after "deploy:migrations", "custom:set_permissions_post_schema_dump", "deploy:cleanup"
    before "deploy:symlink", "custom:get_current_ownership"
    
    after "deploy:symlink", "custom:update_application_controller",
    "custom:yield_current_ownership",
    "custom:set_permissions_for_runtime",
    "custom:recreate_public_link"
    
    namespace(:deploy) do
        desc "Restart the Mongrel processes on the app server."
        task :restart, :roles => :app do
            mongrel.cluster.stop
            sleep 2.5
            mongrel.cluster.start
        end
    end
    
    namespace(:custom) do
    desc "Change ownership of target folders and files to current user"
    task :set_permissions_for_checkout, :except => { :no_release => true } do
        chown of files to current user
        sudo "chown -R #{scm_user}:#{scm_user} #{deploy_to}"
    end
    
    desc "Change ownership of target folders and files to current user"
    task :set_permissions_for_runtime, :except => { :no_release => true } do
        chown of files to current user
        sudo "chown -R #{web_user}:#{web_user} #{deploy_to}"
        sudo "chown #{mongrel_user}.#{mongrel_group} -R #{deploy_to}/current/tmp/pids"
        sudo "chown #{mongrel_user}.#{mongrel_group} -R #{deploy_to}/current/log"
        sudo "chown #{mongrel_user}.#{mongrel_group} -R #{shared_path}/pids"
    end
    
    desc "Recreate link to serve public folders when hosting within subfolder"
    task :recreate_public_link do
        run <<-CMD
            cd #{deploy_to}/current/public && sudo ln -s . #{application}
        CMD
    end
    
    desc "Take temporary ownership of current folder to allow symlink updates"
    task :get_current_ownership do
        sudo "chown #{user}:#{user} #{release_path}"
    end
    
    desc "Take temporary ownership of current folder to allow symlink updates"
    task :yield_current_ownership do
        sudo "chown -R #{web_user}:#{web_user} #{release_path}"
    end
    
    desc "Change ownership of db folders and files to current user"
    task :set_permissions_pre_schema_dump, :except => { :no_release => true } do
        chown of files to current user
        sudo "chown -R #{user}:#{user} #{release_path}/db"
    end
    
    desc "Change ownership of db folders and files to current user"
    task :set_permissions_post_schema_dump, :except => { :no_release => true } do
        chown of files to current user
        sudo "chown -R #{web_user}:#{web_user} #{release_path}/db"
    end
    
    desc "Update application.rb to application_controller.rb"
    task :update_application_controller, :roles => :app do
        run <<-CMD
            cd #{deploy_to}/current/ && sudo rake rails:update:application_controller
        CMD
    end
    
    task :config, :roles => :app do
        run <<-CMD
            sudo ln -nfs #{shared_path}/system/database.yml #{release_path}/config/database.yml
        CMD
    end
    
    desc "Creating symbolic link (custom namespace)"
    task :symlink, :roles => :app do
        run <<-CMD
            sudo ln -nfs #{shared_path}/system/uploads #{release_path}/public/uploads
        CMD
    end
    end
    ```
