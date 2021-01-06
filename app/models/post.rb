class Post < ApplicationRecord
  belongs_to :user
  belongs_to :categories, dependent: :destroy, optional: true
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20 }
  validates :category_id, presence: true
  validates :body, presence: true, length: { maximum: 1000 }
end
