class Public::ShippingAddressesController < ApplicationController
  before_action :authenticate_end_user!, except: [:top,:about,:index]
  def index
    @shipping_addresses = ShippingAddress.all
    @new_address = ShippingAddress.new
  end

  def create
    @new_address = ShippingAddress.new(shipping_address_params)
    if @new_address.save
      redirect_to shipping_addresses_path , notice: "配送先を登録しました"
    else
      @shipping_addresses = ShippingAddress.all
      render :index
    end
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.update(shipping_address_params)
      redirect_to shipping_addresses_path, notice: "配送先の情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.destroy
    redirect_to shipping_addresses_path, notice: "配送先を削除しました"
  end

  private
  def shipping_address_params
    params.require(:shipping_address).permit(:name, :address, :postal_code)
  end
end
