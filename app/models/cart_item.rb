class CartItem < ApplicationRecord
  validates :quantity, presence: true

  belongs_to :item
  belongs_to :end_user

  #累計金額の表示
  # def billing_amount
  #   product.price * quantity
  # end

end
