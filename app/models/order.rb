class Order < ApplicationRecord

    validates :name,:postal_code,:address,
            :payment,:postage,:total_payment,:order_status, presence: true

    belongs_to :end_user
    has_many :order_items

    enum payment_method: {credit_card: 0, transfer: 1}
    enum order_status_method: {backorder: 0, payment_confirmation: 1,  in_production: 2, preparing: 3, sent: 4}
end
