require './config/environment.rb'
         
namespace :db do
  desc "Migrate the database"
  task :migrate do
    # миграция запускается как rake db:migrate VERSION=номер_версии
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end
end



