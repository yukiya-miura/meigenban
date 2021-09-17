class User < ApplicationRecord
    mount_uploader :image, ImageUploader

    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    validates :introduction, presence: false, length: { maximum: 50 } 
    validates :password, presence: true
    
    has_secure_password
    
    
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :favorites
    has_many :like_posts, through: :favorites, source: :post
    
  def favorite(other_post)
    self.favorites.find_or_create_by(post_id: other_post.id)
  end

  def unfavorite(other_post)
    favorite = self.favorites.find_by(post_id: other_post.id)
    favorite.destroy if favorite
  end
  
  def favorite?(other_post)
    self.like_posts.include?(other_post)
  end
end
