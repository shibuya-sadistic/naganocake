class Admins::HomeController < ApplicationController
  def top
  	@orders = Order.where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day)
  end
end
