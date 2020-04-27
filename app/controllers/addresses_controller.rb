class AddressesController < ApplicationController
	before_action :authenticate_customer!
	before_action :correct_customer,{only:[:edit, :destroy]}

def correct_customer
	if @customer.id != current_customer.id
		flash[:notice]="ダメです"
		redirect_to root_path
	end
end
def index
	@customer = Customer.find(current_customer.id)
	@addresses = @customer.addresses
	@address = Address.new
end

def create
	@address = Address.new(address_params)
	@address.customer_id = current_customer.id
	if @address.save
	redirect_to addresses_path(@address)
	else
	@addresses = Address.all
	@address = Address.new
	render 'index'
	end
end

def edit
	@customer = Customer.find(current_customer.id)
	@address = Address.find(params[:id])
end

def update
	@address = Address.find(params[:id])
	if @address.update(address_params)
       redirect_to addresses_path(@address)
    else
       @address = Address.find(params[:id])
       render 'edit'
    end
end

def destroy
	@address = Address.find(params[:id])
	@address.destroy
	redirect_to addresses_path(@address)
end



private
	def address_params
		params.require(:address).permit(:customer_id, :address, :postcode, :destination)
	end

end