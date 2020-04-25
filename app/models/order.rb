class Order < ApplicationRecord
	belongs_to :customer
	has_many :order_items


	enum status:{
		waiting_for_payment: 0,    #入金待ち
		payment_confirmation: 1,   #入金確認
		in_production: 2,          #製作中
		preparing_for_shipping: 3, #発送準備中
		shipped: 4                 #発送済み
	}


	enum payment:{
		bank_transfer: 0, #銀行振込
		credit_card: 1 #クレジットカード
	}


end
