class Admin::OrderItemsController < ApplicationController
    def update
        @order_item = OrderItem.find(params[:id])
        @order_item.update(production_status: params[:order_item][:production_status])
        if @order_item.production_status == "in_production"
            @order_item.order.update(status: "in_production")
        end

        @order_items = OrderItem.where(order_id: @order_item.order_id)
        if @order_items.pluck(:production_status).all? { |production_status| production_status  == "production_completed"}
            @order_item.order.update(status: "preparing")
        end
        redirect_to admin_order_path(@order_item.order_id), notice: '更新に成功しました'
    end

end