class Public::ShippingAddressesController < ApplicationController
  def index
    @shipping_addresses = ShippingAddress.all
    @new_address = ShippingAddress.new
  end
  
  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    if @shipping_address.save
      redirect_to shipping_addresses_path , notice: "配送先を登録しました"
    else
      render :index
    end
  end

  def edit
  end
  
  private
  def shipping_address_params
    params.require(:shipping_address).permit(:name, :address, :postal_code)
  end
end
