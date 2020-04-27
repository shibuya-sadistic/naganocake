class Address < ApplicationRecord
	belongs_to :customer
	validates :destination, presence: true
	validates :postcode, presence: true
	validates :address, presence: true
	def deliverd
		self.postcode + self.address + self.destination
	end
end
