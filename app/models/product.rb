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

  def self.search_for(content, method)
      Product.where('conversion_name LIKE ?', '%'+content+'%')
  end

  def liked_by?(customer)
    likes.where(customer_id: customer.id).exists?
  end

end
