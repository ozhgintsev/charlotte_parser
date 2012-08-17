require './app/models/restaurant.rb'
require './app/models/category.rb'
require './app/models/product.rb'
require './config/environment.rb'

class CharlotteNcParser

  URL = "http://www.restaurants.com/north-carolina/shallotte"

  def parse_charlotte
    Restaurant.destroy_all
    doc = Nokogiri::HTML(open(URL))
    doc.css("select[name=screen]").first.children.css("option").each do |option|
      page = Nokogiri::HTML(open("#{URL}/screen/#{option.attr('value')}"))
      page.css('.listing_summary').each do |restaurant_page|
        parse_restaurant(restaurant_page)
      end
    end
  end

private
  def parse_restaurant(restaurant_page)
    title = restaurant_page.children.css('.listing_summary_header h3 a').text.gsub(/\s+/, " ").strip
    code = restaurant_page.children.css('.listing_summary_body_content_address > span').text
    restaurant_page.children.css('.listing_summary_body_content_address span').remove
    address = restaurant_page.children.css('.listing_summary_body_content_address').text.gsub(/\s+/, " ").strip
    begin
      url = restaurant_page.children.css('.listing_summary_header h3 a').attr('href')
      restaurant_show = Nokogiri::HTML(open(url))
      phone = restaurant_show.css('#lstPhone').text
      site = restaurant_show.css('#lstUrl').text
      restaurant = Restaurant.create(title: title, address: "#{address} #{code}", phone: phone, site: site)
      puts "--------------------------------------------------------------------------"
      puts "#{title} - #{address} #{code} #{phone} #{site}"
      restaurant_show.css('#menuTab .menu_section_group').each do |group|
        parse_category(group, restaurant)
      end
    rescue OpenURI::HTTPError => error
      puts error
    rescue URI::InvalidURIError => error
      puts error
    end
  end
  
  def parse_category(group, restaurant)
    Category.destroy_all
    category_title = group.children.css('.menu_section_title').text
    category_notice = group.children.css('.menu_section_notes').text
    category = Category.create(title: category_title, notice: category_notice)
    puts "============================================================================="
    puts "category #{category.title}"
    puts "============================================================================="
    group.children.css('.menu_item').each do |item|
      parse_product(category, item, restaurant)
    end
  end

  def parse_product(category, item, restaurant)
    product_title = item.children.css('.menu_item_title').text
    product_price = item.children.css('.menu_item_prices').text
    p = Product.create(title: product_title, price: product_price, restaurant: restaurant, category: category)
    puts "#{p.title}"
  end
end
