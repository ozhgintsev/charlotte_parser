require 'rubygems'
require 'active_record'
require 'logger'
require 'yaml'
require 'open-uri'
require 'nokogiri'
         
dbconfig = YAML::load(File.open(File.join(File.dirname(__FILE__), 'database.yml')))
         
#ActiveRecord::Base.logger = Logger.new(STDERR)
         
ActiveRecord::Base.establish_connection(dbconfig)

