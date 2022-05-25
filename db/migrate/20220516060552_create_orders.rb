class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :end_user_id
      t.integer :billing_amount
      t.integer :postages
      t.string :name
      t.string :address
      t.string :postal_code
      t.integer :method_of_payment,default: 0,null: false
      t.integer :status,default: 0,null: false
      t.timestamps
    end
  end
end
