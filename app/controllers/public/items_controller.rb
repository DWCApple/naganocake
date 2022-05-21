class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    #@item = Item.page(params[:page]).per(1)
  end

  def show
    @item = Item.find(params[:id])
    #@cart_item =CartItem
  end

  # private

  # def item_params
  #   params.require(:items).permit(:genre_id,:name,:description,:image_id,:price)
  # end
end
