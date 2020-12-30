class Post < ApplicationRecord
  belongs_to :user
  belongs_to :categories, dependent: :destroy, optional: true
end
