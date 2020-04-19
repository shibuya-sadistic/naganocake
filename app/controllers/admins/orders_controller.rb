class Admins::OrdersController < ApplicationController
	def index
		@orders = Order.page(params[:page])

	end


	def show
		@order = Order.find(params[:id])
		@order_item = OrderItem.find(params[:id])
		@order_items = @order.order_items
	end

	def update
		@order = Order.find(params[:id])
		if @order.update(order_params)
      	redirect_to admins_order_path(@order)
      	end

	end

	private
	def order_params
		params.require(:order).permit(:customer_id, :postage, :destination, :postcode, :address, :payment, :status)
	end

	def order_item_params
		params.require(:order_item).permit(:customer_id, :order_id, :produce_status, :piece, :price)
	end
end
