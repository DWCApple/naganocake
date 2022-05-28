class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!, except: [:sign_in]
  def top
    @orders = Order.all
  end
end
