class CartItemsController < ApplicationController
before_action :authenticate_customer!, only: [:index, :update, :destroy, :destroy_all]

	def create
		unless customer_signed_in?
			flash[:alert] = "ログイン済ユーザーのみカートを利用できます"
			redirect_back(fallback_location: root_path)
		else
			@cart_item = CartItem.new(cart_item_params)
			@cart_item.customer_id = current_customer.id
			if @cart_item.save
				redirect_to cart_items_path, notice:"カートに商品が追加されました。"
		    else
		    	render 'index'
		    end
		end
	end

	def index
		@cart_items = current_customer.cart_items
	end

	def update
		@cart_item = CartItem.find(params[:id])
		@cart_item.update(cart_item_params)
		flash[:notice] = "数量を変更しました"
		@cart_items = current_customer.cart_items
	end

	def destroy
		cart_item=CartItem.find(params[:id])
		cart_item.destroy
		flash[:notice] = "カートから削除しました"
		@cart_items = current_customer.cart_items
	end

	def destroy_all
		unless current_customer.cart_items == []
			cart_items = current_customer.cart_items
			cart_items.destroy_all
			flash[:notice] = "カートを空にしました"
			@cart_items = current_customer.cart_items
		else
			redirect_to cart_items_path
		end
	end

	private
	def cart_item_params
		params.require(:cart_item).permit(:piece, :product_id)
	end

end