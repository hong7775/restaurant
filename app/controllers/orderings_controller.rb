class OrderingsController < ApplicationController
  before_action :authenticate_user, except: [:index]
  
  def index
    # if session[:order_id].present?
    #   @order = Order.find session[:order_id]
    # end
    
    @order = Order.find_by(customer_id: session[:user_id])
    if @order.present?
      session[:order_id] = @order.id
    else
      session[:order_id] = nil
    end
      
    @categories = Category.order("name DESC")
    # if params[:category_id].present?
    #   @menu_items = MenuItem.where(category_id: params[:category_id]).order(:position)
    # else
    #   @menu_items = MenuItem.joins(:category).order("categories.position, menu_items.position")
    # end
  end
  
  def order
    #order_id, menu_item_name = OrderEngine.order(session[:order_id], session[:user_id], params[:menu_item_id], params[:quantity])
    # order_machine = OrderMachine.new(session[:order_id], session[:user_id], params[:menu_item_id], params[:quantity])
    
    # if order_machine.valid?
    #   order_machine.ordering
    #   session[:order_id] = order_machine.order.id
    #   flash[:notice] = "you have just order #{order_machine.menu_item.name}"
    # else
    #   flash[:alert] = "you need a valid quantity"
    # end
    # redirect_to action: :index
  end
  
  def checkout
    @order = Order.find(session[:order_id])
    if @order.order_items.blank?
      flash[:alert] = "You have to order first"
      redirect_to orderings_path
    end
  end
  
end
