class Admins::ProductsController < ApplicationController

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
      @products = Product.page(params[:page])
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
