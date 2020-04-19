class CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end

  def quit
  end

  def update
    if current_customer.update_with_password(customer_params)
      redirect_to account_path
    else
      render :edit
    end
  end

  def hide
    current_customer.update(status: false)
    session.clear
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:password, :password_confirmation, :status)
  end
end
