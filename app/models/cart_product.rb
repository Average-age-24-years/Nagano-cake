class CartProduct < ApplicationRecord

  belongs_to :product
  belongs_to :customer

  validates :product_id,  presence: true
  validates :customer_id,  presence: true
  validates :quantity,  presence: true

  def self.add_tax_price(price)
    (price * 1.10).round.to_s(:delimited)
  end

  def self.sum_of_price
    (self.price * 1.10) * self.quantity.round.to_s(:delimited)
  end

end
