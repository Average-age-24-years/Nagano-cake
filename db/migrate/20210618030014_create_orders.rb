class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer  :customer_id,    null: false
      t.string   :post_code,      null: false
      t.string   :address,        null: false
      t.string   :name,           null: false
      t.integer  :shipping,       null: false
      t.integer  :total_price,    null: false
      t.integer  :payment,        null: false, default: 0
      t.integer  :order_status,   null: false, default: 0

      t.timestamps                null: false
    end
  end
end
