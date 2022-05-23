class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @order.end_user_id = current_end_user.id
    @current_addresses = EndUser.select(:postal_code, :shipping_address, :last_name, :first_name)
    @address = Address.new
  end

  def about
    @order = Order.new(order_params)
    @cart_items = current_end_user.cart_items.all
    @total_price = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @total_payment = @total_price + @order.postage
    if params[:order][:order_addresses] == '0'
      @order.postal_code = current_end_user.postal_code
      @order.address = current_end_user.address
      @order.name = current_end_user.last_name + current_end_user.first_name
    elsif params[:order][:order_addresses] == '1'
      if ShippingAddress.exists?(id: params[:order][:address_id])
        @order.name = ShippingAddress.find(params[:order][:address_id]).name
        @order.address = ShippingAddress.find(params[:order][:address_id]).shipping_address
        @order.postal_code = ShippingAddress.find(params[:order][:address_id]).postal_code
      else
        flash.now[:notice] = '配送先が登録されていません'
        render 'new'
      end
    elsif params[:order][:order_addresses] == '2' && @order.postal_code? && @order.shipping_address? && @order.name?
    else
      flash.now[:notice] = '未選択の選択肢があります'
      render 'new'
    end
  end

  def create
    @cart_items = current_end_user.cart_items.all
    p @order = current_end_user.orders.new(order_params)
    if @order.save
      @cart_items.each do |cart|
      order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.item_quantity = cart.item_amount
        order_detail.price = cart.item.add_tax_price
        order_detail.save
      end
      current_end_user.cart_items.destroy_all
      redirect_to thanks_path
    else
      @order = Order.new(order_params)
      render 'new'
    end

  end

  def index
    @orders = Order.where(end_user_id: current_end_user.id)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total_price = 0
  end

  private

  def order_params
    params.require(:order).permit(:end_user_id, :name, :postal_code, :shipping_address, :payment, :postage, :total_payment, :order_status)
  end

  def address_params
    params.require(:shipping_address).permit(:postal_code, :shipping_address, :name)
  end
end
