require "spec_helper"
require "./app/models/category.rb"
require "./app/models/product.rb"

describe Category do
  
  it { should respond_to(:title) }
  it { should respond_to(:products) }
  
  describe "product associations" do
    it { should have_many(:products) }
  end

end
