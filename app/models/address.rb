class Address < ApplicationRecord
	belongs_to :customer
	def deliverd
		self.postcode + self.address + self.destination
	end
end
