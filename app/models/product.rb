class Product < ApplicationRecord

  attachment :image

  belongs_to :genre

  has_many :cart_products

  has_many :order_products, dependent: :destroy

  has_many :likes, dependent: :destroy

  validates :name,  presence: true
  validates :genre_id,  presence: true
  validates :image,  presence: true
  validates :introduction,  presence: true
  validates :price,  presence: true
  validates :is_active,  presence: true

  def self.search_for(content, method)
      Product.where('name LIKE ?', '%'+content+'%')
  end

  def liked_by?(customer)
    likes.where(customer_id: customer.id).exists?
  end

  def self.sort(selection)
    case selection
    when 'new'
      return order(created_at: :DESC)
    when 'low_price'
      return order(price: :ASC)
    when 'likes'
      return joins(:order_products).group(:order_id).order('count(product_id) desc')
    end
  end
end
