class Product < ApplicationRecord

  attachment :image

  belongs_to :genre

  has_many :cart_products

  has_many :order_products, dependent: :destroy

  validates :name,  presence: true
  validates :genre_id,  presence: true
  validates :image,  presence: true
  validates :introduction,  presence: true
  validates :price,  presence: true
  validates :is_active,  presence: true
  
  def self.search_for(content, method)
      Product.where('name LIKE ?', '%'+content+'%')
  end

end
