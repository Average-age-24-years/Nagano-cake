class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :last_name,        presence: true
  validates :first_name,       presence: true
  validates :last_name_kana,   presence: true
  validates :first_name_kana,  presence: true
  validates :email,            presence: true,
                               uniqueness: true,
                               format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :postal_code,      presence: true
  validates :address,          presence: true
  validates :telephone_number, presence: true
  validates :password,         presence: true
  
   
   #enum is_deleted: {Available: true, Invalid: false} 

    #def active_for_authentication?
     #   super && (self.is_deleted === "Invalid")
    #end
end
