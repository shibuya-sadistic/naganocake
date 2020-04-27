class OrdersController < ApplicationController
	def new
	end

	def confirm
		@order = Order.new
		if params[:address] == "ご自身の住所"
			@order.postcode = current_customer.postcode
			@order.address = current_customer.address
			@order.destination = current_customer.last_name
		elsif params[:address] == "既存の住所"
			@address = Address.find(params[:pre_address])
			@order.postcode = @address.postcode
			@order.address = @address.address
			@order.destination = @address.destination
		else params[:address] == "新しいお届け先"
			@address = Address.new
			@address.postcode = params[:postcode]
			@address.address = params[:new_address]
			@address.destination = params[:destination]
			@order.postcode = @address.postcode
			@order.address = @address.address
			@order.destination = @address.destination
		end
			@cart_items = current_customer.cart_items
		@order.payment = params[:payment].to_i
	end

	def create
		@order = Order.new
		@order.status = 0
		@order.postcode = params[:postcode]
		@order.address = params[:address]
		@order.destination = params[:destination]
		@order.payment = params[:payment].to_i
		@order.customer_id = current_customer.id
		@order.save
		@cart_items = current_customer.cart_items
		@cart_items.each do |cart_item|
			@order_item = OrderItem.new
			@order_item.produce_status = 0
			@order_item.price = cart_item.product.price
			@order_item.order_id = @order.id
			@order_item.product_id = cart_item.product_id
			@order_item.piece = cart_item.piece
			if@order_item.save
				cart_item.destroy
			end
		end
		if 	params[:new_address]
			@address = Address.new
			@address.postcode = params[:new_postcode]
			@address.destination = params[:new_destination]
			@address.address = params[:new_address]
			@address.customer_id = current_customer.id
		    @address.save
		end
		redirect_to complete_orders_path
	end

	def complete
	end

	def index
		@orders=current_customer.orders
	end

	def show
		@order=Order.find(params[:id])
	end

	private
	def order_params
	params.require(:order).permit(:customer_id,:postage, :destination, :address, :postcode, :payment)
	end
end