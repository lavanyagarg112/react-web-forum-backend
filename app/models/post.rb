# app/models/post.rb
class Post < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Validations
  validates :author_name, presence: true
end
