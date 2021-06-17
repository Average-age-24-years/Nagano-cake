class CartProduct < ApplicationRecord

  belongs_to :product
  belongs_to :customer

  validates :product_id,  presence: true
  validates :customer_id,  presence: true
  validates :quantity,  presence: true

  def subtotal(price, quantity)
		quantity * (price * 1.10).round
  end

end
