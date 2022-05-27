class Order < ApplicationRecord

    validates :name,:postal_code,:address,
              :method_of_payment,:postages,:billing_amount,:status, presence: true

    belongs_to :end_user
    has_many :order_items

    enum payment_method: {credit_card: 0, transfer: 1}
    enum status: {backorder: 0, payment_confirmation: 1,  in_production: 2, preparing: 3, sent: 4}
end
