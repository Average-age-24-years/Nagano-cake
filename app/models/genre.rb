class Genre < ApplicationRecord

  has_many :products
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, format: {with: VALID_EMAIL_REGEX}, allow_blank: true
  validates :name,  presence: true
  
  def self.search_for(content, method)
      Genre.where('conversion_name LIKE ?', '%'+content+'%') 
  end

end
