class Admins::OrderItemsController < ApplicationController
  before_action :authenticate_admin!
  
	def update
		@order_item = OrderItem.find(params[:id])
      	@order_item.update(order_item_params)
      	@order = @order_item.order
      	@order_items = @order.order_items

      	if @order.status == "payment_confirmation" #注文ステータスが入金確認の場合
			    if @order_item.previous_changes[:produce_status][0] == "awaiting_production" && @order_item.previous_changes[:produce_status][1] == "in_production"
     		  		@order.update(status: 2) #注文ステータスを製作中へ更新する
      	  end
      	elsif @order.status == "in_production" #注文ステータスが製作中の場合
              total = 0
              @order_items.each do |order_item|
      		    #if @order_item.previous_changes[:produce_status][0] == "in_production" && @order_item.previous_changes[:produce_status][1] == "production_completed"
                if order_item.produce_status == "production_completed"
                   total += 1
                end
              end
              if @order_items.count == total #orderに紐づくorder_itemの総数とproduction_completedのorder_itemの数
                @order.update(status: 3) #注文ステータスを発送準備中へ更新する
              end
      	end



      	
      	# redirect_to admins_order_path(@order), turbolinks: false
     	# redirect_to admins_order_path(order.id)
	end

	private
	def order_item_params
		params.require(:order_item).permit(:customer_id, :order_id, :produce_status, :piece, :price)
	end

end
