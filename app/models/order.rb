class Order < ApplicationRecord
	belongs_to :customer
	has_many :order_items

	# included AASM

	enum status:{
		waiting_for_payment: 0,    #入金待ち
		payment_confirmation: 1,   #入金確認
		in_production: 2,          #製作中
		preparing_for_shipping: 3, #発送準備中
		shipped: 4                 #発送済み
	}, _prefix: true

	# aasm column: :status,enum: :true do
	# 	state :waiting_for_payment, initial:true
	# 	state :payment_confirmation
	# 	state :in_production
	# 	state :preparing_for_shipping
	# 	state :shipped

	# 	event :pay do
	# 		transitions :from => :waiting_for_payment, :to => :payment_confirmation
	# 	end

	# 	event :confirm do
	# 		transitions :from => :payment_confirmation
	# 	end

	# 	event :produce do
	# 		transitions :from => :in_production
	# 	end

	# 	event :shioong do
	# 		transitions :from => :preparing_for_shipping
	# 	end

	# 	event :shipped do
	# 		transitions :from => :shipped
	# 	end
	# end


	enum payment:{
		bank_transfer: 0, #銀行振込
		credit_card: 1 #クレジットカード
	}

end
