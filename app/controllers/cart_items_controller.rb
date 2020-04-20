class CartItemsController < ApplicationController
	before_action :authenticate_user!
def create
	@cart_item=Cart_item.new(cart_item.id)
	@cart_item.save
	redirect_to_root_path
end
def index
	@cart_items = current_customer.cart_items.all
	@product=@cart_item.product
end
def update
	@cart_item = Cart_item.find(params[:id])
end
def destroy
	cart_item=Cart_item.find(palams[:id])
end
def destroy_all
	cart_item=Cart_item.find(palams[:id])
end

private
def cart_item_params
	params.require(:cart_item).parmit(:piece, :customer_id, :product_id)
end
end