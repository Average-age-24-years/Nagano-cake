class Genre < ApplicationRecord

  has_many :products

  validates :name,  presence: true
  
  def self.search_for(content, method)
      Genre.where('name LIKE ?', '%'+content+'%')
  end

end
