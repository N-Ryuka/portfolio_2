class Post < ApplicationRecord
  belongs_to :user
  belongs_to :categories, dependent: :destroy, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :post_tag_relations
  has_many :tags, through: :post_tag_relations

  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 1000 }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
