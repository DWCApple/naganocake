class Public::HomesController < ApplicationController
  before_action :authenticate_end_user!, except: [:top,:about,:index]
  def top
    @items = Item.all
  end
end
