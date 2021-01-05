class Post < ApplicationRecord
  belongs_to :user
  belongs_to :categories, dependent: :destroy, optional: true

  validates :title, presence: true
  validates :category_id, presence: true
  validates :body, presence: true
end
