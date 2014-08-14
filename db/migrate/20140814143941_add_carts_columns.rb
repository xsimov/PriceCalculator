class AddCartsColumns < ActiveRecord::Migration
  def change
    add_column :carts, :number_items, :integer
    add_column :carts, :item_price, :integer
    add_column :carts, :country_id, :string
  end
end