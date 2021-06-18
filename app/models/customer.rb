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
  validates :password,         presence: true, on: :create
  
  has_many :distinations, dependent: :destroy
  
  # ユーザーの'is_deleted'をタイムスタンプで更新
  def soft_delete  
    update_attribute(:is_deleted, Time.current)  
  end

  # ユーザーのアカウントが有効であることを確認しています
  def active_for_authentication?  
    super && !is_deleted 
  end  

  # 削除したユーザーにメッセージを追加します  
  def inactive_message   
    !is_deleted ? super : :"アカウントは削除されています" 
  end 
  
end
