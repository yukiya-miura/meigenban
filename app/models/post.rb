class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre, optional: true
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :author, presence: false, length: {maximum: 50 }
  validates :wordby, presence: false, length: {maximum: 50 }
  
  has_many :comments, dependent: :destroy
  
end
