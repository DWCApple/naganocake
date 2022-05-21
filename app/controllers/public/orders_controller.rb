class Public::OrdersController < ApplicationController
  def about
    @order = Order.new
    @end_user = currrent_customer
    @currrent_addresses = End_user.select(:postal_code, :adress, :name)
    @adresses = Address.new
  end

  def compleate
  end

  def index
  end

  def new
  end

  def show
  end
  
  
end
