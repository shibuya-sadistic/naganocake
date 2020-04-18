class ProductsController < ApplicationController
  def index
  	if params[:id]
  		@products = Product.where(genre_id: params[:id])
  		@genres = Genre.all
  	else
	  	@products = Product.all
	  	@genres = Genre.all
	end
  end

  def show
  	@product = Product.find(params[:id])
  	@genres = Genre.all
  	@cart_item = CartItem.new
  end
end
