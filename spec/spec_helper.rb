require './config/environment.rb'
require 'rspec'
require 'webmock/rspec'
require 'shoulda/matchers'

RSpec.configure do |config|

  config.mock_with :rspec

end
