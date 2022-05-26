class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_status = Order.new(order_params)
  end
  
  def update
    @orders = Order.new(order_params)
  end
  
  private
  
  def order_params
    params.require(:orders).permit(:status)
  end
end
