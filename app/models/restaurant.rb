require 'rubygems'
require 'active_record'

class Restaurant < ActiveRecord::Base
  has_many :products, :dependent => :destroy
end
