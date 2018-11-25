class PaymentsController < ApplicationController
  
  def new
    @order = Order.find session[:order_id]
  end
  
  def create
    flash[:notice] = "Order confirmed, Payment make successfully, Thank You"
    # @order.is_checked_out = true
    session[:order_id] = nil
    session[:user_id] = nil
    redirect_to login_path
  end
end
