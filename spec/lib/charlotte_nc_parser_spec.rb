require "spec_helper"
require "./lib/charlotte_nc_parser.rb"
require "./app/models/restaurant.rb"

describe CharlotteNcParser do

  before(:each) do

    @select_options = ["<option value='1'>1</option>","<option value='2'>2</option>"]
    
    @restaurant_attr = {title: "Andy's Burgers Shakes Fries", address: "4501 Main St Ste 7 South Brunswick, NC", code: "28470", site: "http://www.andyscheesesteaks.com/", phone: "(919) 658-3668"}

    stub_request(:get, "http://www.restaurants.com/north-carolina/shallotte").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "<select name='screen'>#{@select_options.join}</select>", :headers => {})

    stub_request(:get, /^http:\/\/www\.restaurants\.com\/north-carolina\/shallotte\/.+/).
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "", :headers => {})

    stub_request(:get, "http://www.restaurants.com/north-carolina/shallotte/screen/1").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "<div class='listing_summary citygrid'><div class='listing_summary_header'><h3><a href='http://www.restaurants.com/north-carolina/shallotte/andys-burgers-shakes-and-fries'>#{@restaurant_attr[:title]}</a></h3></div><p class='listing_summary_body_content_address'>#{@restaurant_attr[:address]}<span class='zip'>#{@restaurant_attr[:code]}</span></p></div>", :headers => {})

    stub_request(:get, "http://www.restaurants.com/north-carolina/shallotte/andys-burgers-shakes-and-fries").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "<span id='lstPhone'>#{@restaurant_attr[:phone]}</span><a id='lstUrl' href='http://www.andyscheesesteaks.com/' target='_blank'>#{@restaurant_attr[:site]}</a>", :headers => {})

    @parser = CharlotteNcParser.new
    @parser.parse_charlotte
  end

  it "should send get request to charlotte page" do
    WebMock.should have_requested(:get, "http://www.restaurants.com/north-carolina/shallotte")
  end
  
  it "should send get request to each screen page" do
    @select_options.each_with_index do |option, i|
      WebMock.should have_requested(:get, "http://www.restaurants.com/north-carolina/shallotte/screen/#{i+1}")
    end
  end
  
  it "should parse right href attr and send request to it" do
    WebMock.should have_requested(:get, "http://www.restaurants.com/north-carolina/shallotte/andys-burgers-shakes-and-fries")
  end
  
  it "should save right restaurant object" do
    restaurant = Restaurant.first
    restaurant.title.should   == @restaurant_attr[:title]
    restaurant.address.should == "#{@restaurant_attr[:address]} #{@restaurant_attr[:code]}"
    restaurant.site.should    == @restaurant_attr[:site]
    restaurant.phone.should   == @restaurant_attr[:phone]
  end

end
