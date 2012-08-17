require "spec_helper"
require "./app/models/restaurant.rb"
require "./app/models/product.rb"
require "./app/models/category.rb"

describe Product do
  
  it "should create a new instance" do
    restaurant = Restaurant.create(title: "Andy's Burgers Shakes & Fries")
    category = Category.create(title: "Drinks")
    Product.create!(title: 'coca-cola', price: '$25', category: category, restaurant: restaurant)
  end
  
  it { should respond_to(:title) }
  it { should respond_to(:price) }
  it { should respond_to(:restaurant) }
  it { should respond_to(:category) }
  
  describe "product associations" do
    it { should belong_to(:category) }
    it { should belong_to(:restaurant) }
  end

end
