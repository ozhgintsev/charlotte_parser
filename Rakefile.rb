require './config/environment.rb'

require './lib/charlotte_nc_parser.rb'
         
namespace :db do
  desc "Migrate the database"
  task :migrate do
    # миграция запускается как rake db:migrate VERSION=номер_версии
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end
end

namespace :parsers do
  desc "Parse charlotte"
  task :parse_charlotte do
    CharlotteNcParser.new.parse_charlotte
  end
end




