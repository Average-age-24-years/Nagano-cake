class OrderProduct < ApplicationRecord

  belongs_to :order
  belongs_to :product

  enum product_status: { "着手待ち": 0, "製作待ち": 1, "製作中": 2, "製作完了": 3}

  def subtotal(price, quantity)
		quantity * (price * 1.10).round
  end

end
