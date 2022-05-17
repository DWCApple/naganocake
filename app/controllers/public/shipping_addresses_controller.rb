class Public::ShippingAddressesController < ApplicationController
  def index
    @shipping_addresses = ShippingAddress.all
    @new_address = ShippingAddress.new
  end

  def edit
  end
  
  private
  def shipping_address_params
    params.require(:shipping_address).permit(:name, :address, :postal_code)
  end
end
