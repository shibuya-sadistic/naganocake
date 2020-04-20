class Admins::OrdersController < ApplicationController
	def index
		@orders = Order.page(params[:page])

	end


	def show
		@order = Order.find(params[:id])
		@order_items = @order.order_items
	end

	def update

		@order = Order.find(params[:id])
		@order_items = @order.order_items
		@order.update(order_params)


		if @order.previous_changes[:status][0] == "waiting_for_payment" && @order.status == "payment_confirmation" #注文ステータス：更新前が0、今は1
			@order_items.update_all(produce_status: 1) #制作ステータスを1に変更

			# 	if i.produce_status == 0 #制作ステータスが着手不可
			# 	   i.update(produce_status == 1) #制作ステータスを制作待ちへ更新
			# 	else i.produce_status == 1 #制作ステータスが制作待ち
			# 　　	redirect_to admins_order_path
			# 	end
      	end

      	redirect_to admins_order_path(@order), turbolinks: false

	end

	private
	def order_params
		params.require(:order).permit(:customer_id, :postage, :destination, :postcode, :address, :payment, :status)
	end

end

