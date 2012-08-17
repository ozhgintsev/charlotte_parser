class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :title
      t.string :price
      t.integer :category_id
      t.integer :restaurant_id
    end
  end
       
  def self.down
    drop_table :products
  end
end

