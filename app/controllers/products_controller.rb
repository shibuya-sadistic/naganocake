class ProductsController < ApplicationController
  def index
  	if params[:genre_id] && Genre.find(params[:genre_id]).status == true
  		@preproducts = Product.where(genre_id: params[:genre_id])
      @products = @preproducts.page(params[:page]).per(12)
  		@genres = Genre.where(status: true)
      @genre = Genre.find(params[:genre_id])
  	else
      if params[:search]
        preproducts = Product.where(['name LIKE ?', "%#{params[:search]}%"])
      else
        preproducts = Product.all
      end
      @products = []
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
