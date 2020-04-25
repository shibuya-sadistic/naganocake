class OrderItem < ApplicationRecord
	belongs_to :order
	belongs_to :product

	enum produce_status: {
		cannot_start: 0,          #着手不可
		awaiting_production: 1,   #製作待ち
		in_production: 2,         #製作中
		production_completed: 3   #製作完了
	}
end
