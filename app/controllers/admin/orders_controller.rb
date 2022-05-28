class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path(@order.id), notice: '更新に成功しました'
    end
  end

  private

  def order_params
    params.require(:order).permit(:status, :order_items_id, :end_users_id)
  end
end
