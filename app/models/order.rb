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
  #has_many :order_products,   dependent: :destroy
end
