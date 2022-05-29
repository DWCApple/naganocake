class Public::ItemsController < ApplicationController
  before_action :authenticate_end_user!, except: [:top,:about,:index]
  def index
    @items = Item.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def item_params
   params.require(:items).permit(:genre_id,:name,:price)
  end
end
