class Product < ApplicationRecord
	has_many :cart_items
	has_many :order_items
	belongs_to :genre
	attachment :image
end
