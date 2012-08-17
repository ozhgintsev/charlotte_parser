require 'rubygems'
require 'active_record'

class Category < ActiveRecord::Base
  has_many :products, :dependent => :destroy
end
