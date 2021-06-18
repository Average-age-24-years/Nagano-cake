class Product < ApplicationRecord

  attachment :image

  belongs_to :genre
  
  has_many :cart_products

  validates :name,  presence: true
  validates :genre_id,  presence: true
  validates :image,  presence: true
  validates :introduction,  presence: true
  validates :price,  presence: true
  validates :is_active,  presence: true

end
