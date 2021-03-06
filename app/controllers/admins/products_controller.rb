class Admins::ProductsController < ApplicationController
  before_action :authenticate_admin!

  def new
      @product = Product.new

  end

  def create
      @product = Product.new(product_params)
      if @product.save
      redirect_to admins_product_path(@product)
      else
      @product = Product.new
      render 'new'
      end

  end

  def show
      @product = Product.find(params[:id])
  end

  def index
      # genre = Genre.where(status: true)
      # @products = Product.where(genre_id: params[:genre_id])
      if params[:search]
        @products = Product.where(['name LIKE ?', "%#{params[:search]}%"]).page(params[:page])
      else
        @products = Product.page(params[:page])
      end

  end

  def edit
      @product = Product.find(params[:id])

  end

  def update
      @product = Product.find(params[:id])
      if @product.update!(product_params)
      redirect_to admins_product_path(@product)
      else
      render 'edit'
      end
  end

  private
  def product_params
      params.require(:product).permit(:name, :introduction, :genre_id, :price, :status, :image)
  end
end
