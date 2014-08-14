require 'pry'
class CartsController < ApplicationController

  TAX = {
    es: 1.21,
    de: 1.19,
    fr: 1.12,
    no: 1.35,
    it: 1.20,
  }

  DISCOUNT = [
    [0, 1],
    [100, 0.98],
    [500, 0.97],
    [1000, 0.95],
    [3000, 0.93],
    [12000, 0.90],
  ]

  def index
    @cart = Cart.new
  end

  def create
    @cart = Cart.new cart_params

    no_taxes = @cart.number_items * @cart.item_price

    discount = DISCOUNT.select { |values| values.first < no_taxes }
    discount_to_apply = discount.last

    subtotal = no_taxes.to_f * discount_to_apply.last
    
    @total = subtotal * TAX[@cart.country_id.to_sym]

    render 'index'
  end

  def cart_params
    params.require(:cart).permit(:number_items, :item_price, :country_id)
  end

end