require 'rubygems'
require 'active_record'

class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :restaurant
end
