class Admins::OrderItemsController < ApplicationController
	def update
		@order_item = OrderItem.find(params[:id])
      	if @order.update(order_item_params)
      		redirect_to admins_order_path(@order)
      	end
	end

	private
	def order_item_params
		params.require(:order_item).permit(:customer_id, :order_id, :produce_status, :piece, :price)
	end

end
