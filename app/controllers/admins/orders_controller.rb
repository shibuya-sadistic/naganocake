class Admins::OrdersController < ApplicationController
	before_action :authenticate_admin!
	def index
		if params[:created_at]
			@orders = Order.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).page(params[:page]).order('created_at desc')

		elsif params[:customer_id]
			@customer = Customer.find_by(params[:customer_id])
			@orders = Order.where(customer_id: params[:customer_id]).page(params[:page])

		else
			@orders = Order.page(params[:page]).order('created_at desc')
		end
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
			@order_items.update_all(produce_status: 1) #制作ステータスを1:製作待ちに変更（全てのorder_item）

      	end

      	redirect_to admins_order_path(@order), turbolinks: false

	end

	private
	def order_params
		params.require(:order).permit(:customer_id, :postage, :destination, :postcode, :address, :payment, :status)
	end

end

