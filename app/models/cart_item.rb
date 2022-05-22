class CartItem < ApplicationRecord
  validates :quantity, presence: true

  belongs_to :item
  belongs_to :end_user

  #累計金額の表示
  def subtotal
    item.add_tax_price * quantity
  end

end
