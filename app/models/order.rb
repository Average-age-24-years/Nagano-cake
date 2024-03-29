class Order < ApplicationRecord

  validates  :customer_id,    presence: true
  validates  :post_code,      presence: true
  validates  :address,        presence: true
  validates  :name,           presence: true
  validates  :shipping,       presence: true
  validates  :total_price,    presence: true
  validates  :payment,        presence: true
  validates  :order_status,   presence: true

  belongs_to :customer
  has_many :order_products,   dependent: :destroy

  enum order_status: { "入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4 }
  enum payment: { "クレジットカード": 0, "銀行振込": 1 }

end
