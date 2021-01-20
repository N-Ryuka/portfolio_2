class Comment < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :user
  has_many :notifications, dependent: :destroy


  validates :content, presence: true
end
