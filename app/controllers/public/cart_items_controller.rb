class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_end_user.cart_items
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.end_user_id = current_end_user.id
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.end_users_id = current_end_user.id
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.delete
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items = CartItem.where(end_users_id: current_end_user)
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id,:quantity)
  end
end
