class Public::CartItemsController < ApplicationController
  before_action :authenticate_end_user!, except: [:top,:about,:index]
  # before_action:authenticate_end_user!

  def index
    @total_price = 0
    @cart_items = current_end_user.cart_items
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.end_user_id = current_end_user.id

    if !CartItem.find_by(item_id: @cart_item.item.id).nil?
      new_cart_item = CartItem.find_by(item_id: @cart_item.item.id)
      new_cart_item.quantity += @cart_item.quantity.to_i
      new_cart_item.save
      redirect_to cart_items_path
    else
      @cart_item.save
      redirect_to cart_items_path
    end

  end

  def update
   @cart_item = CartItem.find(params[:id])
   @cart_item.end_user_id = current_end_user.id
   @cart_item.update(cart_item_params)
   redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.delete
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items = CartItem.where(end_user_id: current_end_user)
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id,:quantity)
  end
end