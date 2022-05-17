class Public::CartItemsController < ApplicationController
  before_action:authenticate_end_user!
  def index
  end

  def create
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
