class CreateRestaurants < ActiveRecord::Migration
  def self.up
    create_table :restaurants do |t|
      t.string :title
      t.string :address
      t.string :phone
      t.string :site
    end
  end
       
  def self.down
    drop_table :restaurants
  end
end

