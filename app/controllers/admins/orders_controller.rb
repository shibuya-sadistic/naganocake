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
		# @order_items = @order.order_items
		@order.update(order_params)

		if @order.status == 1 #注文ステータスが入金確認
			@order_items.each do |i|
			if i.produce_status == 0 #制作ステータスが着臭不可
			   i.update(produce_status == 1) #制作ステータスを制作待ちへ更新
			else i.produce_status == 1 #制作ステータスが制作待ち
			　　redirect_to admins_order_path
			end
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
end

