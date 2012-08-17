require "spec_helper"
require "./app/models/restaurant.rb"
require "./app/models/product.rb"

describe Restaurant do
  
  it { should respond_to(:title) }
  it { should respond_to(:products) }
  
  describe "product associations" do
    it { should have_many(:products) }
  end

end
