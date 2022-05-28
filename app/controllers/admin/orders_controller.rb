class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status == "payment_confirmation"
      @order.order_items.each do |order_item|
        order_item.production_status = "production_wait"
        order_item.save
      end
    end
      redirect_to admin_order_path(@order.id), notice: '更新に成功しました'
  end

  private

  def order_params
    params.require(:order).permit(:status, :order_items_id, :end_users_id)
  end
end
