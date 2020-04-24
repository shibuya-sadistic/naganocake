class Product < ApplicationRecord
	has_many :cart_items
	has_many :order_items
	belongs_to :genre
	attachment :image

	with_options presence: true do
    validates :name
    validates :introduction
    validates :price
  	end

  	validates :price, numericality: { only_integer: true } #全角で入力しても半角に変更してくれる

  	def price=(value)
    value.tr!('０-９', '0-9') if value.is_a?(String)
    super(value)
  end

end
