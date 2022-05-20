class Item < ApplicationRecord
  has_one_attached :image
  validates :name, :price, :description, :image, presence: true
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
end
