class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre, optional: true
  
  validates :genre_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :author, presence: true, length: {maximum: 50 }
  validates :wordby, presence: true, length: {maximum: 50 }
  
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, source: :user
  
end
