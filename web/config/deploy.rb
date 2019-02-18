# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]

set :application, 'Ordering-system'
set :repo_url, 'git@github.com:arsley/Ordering-system.git'
set :repo_tree, 'web'
set :deploy_to, '/www/dev.arsley.work/Ordering-system'
set :branch, ENV['BRANCH_NAME'] || 'production'

set :migration_role, :web
set :migration_servers, -> { primary(fetch(:migration_role)) }

set :passenger_restart_with_touch, true
set :passenger_roles, :web

namespace :deploy do
  desc 'Copy environments'
  after :finished, :copy_env do
    on roles(:web) do
      execute "cd #{release_path} && cp .env.sample .env"
    end
  end

  # https://stackoverflow.com/questions/20536112/how-to-insert-a-new-line-in-linux-shell-script
  desc 'Generate secrets'
  after :finished, :generate_secrets do
    on roles(:web) do
      execute "cd #{release_path} && echo -e \"production:\\n  secret_key_base: `#{fetch :rbenv_prefix} bundle exec rails secret`\" > config/secrets.yml"
    end
  end

  desc 'Generate link for sub URI'
  after :finished, :generate_link do
    on roles(:web) do
      execute "ln -s #{fetch(:deploy_to)}/current/public /www/dev.arsley.work/ordering"
    end
  end

  desc 'Seeds root data'
  after :finished, :seeds_root_data do
    on roles(:web) do
      execute "cd #{release_path} && #{fetch :rbenv_prefix} bundle exec rails db:seed"
    end
  end

  after :finished, :'passenger:restart'
end
