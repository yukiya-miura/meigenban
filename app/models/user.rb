class User < ApplicationRecord
    mount_uploader :image, ImageUploader

    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    validates :introduction, presence: false, length: { maximum: 50 } 
    
    has_secure_password
    
    has_many :posts, dependent: :destroy
    has_many :comments
end
