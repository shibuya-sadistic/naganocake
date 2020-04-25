class CartItemsController < ApplicationController
before_action :authenticate_customer!
def create

	@cart_item = CartItem.new(cart_item_params)
	@cart_item.customer_id = current_customer.id
	if @cart_item.save
		redirect_to cart_items_path, notice:"カートに商品が追加されました。"
    else render 'index'
    end
end
def index
	@cart_items = current_customer.cart_items.all
end
def update
	@cart_item = CartItem.find(params[:id])
	@cart_item.update(cart_item_params)
	redirect_to cart_items_path
end

def destroy
	cart_item=CartItem.find(params[:id])
	cart_item.destroy
	redirect_to cart_items_path
end
def destroy_all
	cart_items = current_customer.cart_items
	cart_items.destroy_all
	redirect_to cart_items_path,notice:"カートを空にしました"
end

private
def cart_item_params
	params.require(:cart_item).permit(:piece, :product_id)
end
end