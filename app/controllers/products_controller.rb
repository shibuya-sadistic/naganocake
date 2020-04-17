class ProductsController < ApplicationController
  def index
  	@products = Product.all
  	@genres = Genre.all
  end

  def show
  	@product = Product.find(params[:id])
  	@genres = Genre.all
  	@cart_item = CartItem.new
  end
end
