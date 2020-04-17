class HomeController < ApplicationController
	def top
		@genres = Genre.all
		@products = Product.all #おすすめ順を何の順にするのかどうか？
	end
	def about
	end
end
