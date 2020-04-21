class HomeController < ApplicationController
	def top
		@genres = Genre.all
		@products = Product.all.order(id: "DESC") #おすすめ順を何の順にするのかどうか？
	end
	def about
	end
end
