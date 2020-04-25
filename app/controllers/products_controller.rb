class ProductsController < ApplicationController
  def index
  	if params[:genre_id]
  		preproducts = Product.where(genre_id: params[:genre_id])
      @products = preproducts.page(params[:page])
  		@genres = Genre.all
  	else
	  	@products = Product.page(params[:page])
	  	@genres = Genre.all
    end
  end

  def show
  	@product = Product.find(params[:id])
  	@genres = Genre.all
  	@cart_item = CartItem.new
  end
end
