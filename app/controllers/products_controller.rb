class ProductsController < ApplicationController
  def index
  	if params[:genre_id]
  		@preproducts = Product.where(genre_id: params[:genre_id])
      @products = @preproducts.page(params[:page]).per(12)
  		@genres = Genre.where(status: true)
  	else
      @products = []
      preproducts = Product.all
      preproducts.each do |product|
        if product.genre.status == true
          @products.push [product]
        end
      end
      @preproducts = Product.where(id: @products.map{ |product| product[0][:id]})

	  	@products = Kaminari.paginate_array(@preproducts).page(params[:page]).per(12)
	  	@genres = Genre.where(status: true)
    end
  end

  def show
  	@product = Product.find(params[:id])
  	@genres = Genre.all
  	@cart_item = CartItem.new
  end
end
