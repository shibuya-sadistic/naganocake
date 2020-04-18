class CustomersController < ApplicationController
  def show
    @customer = Customer.find(1)
  end

  def quit
  end

  def edit
  end

  def update
  end

  def hide
  end
end
