# app/models/tag.rb
class Tag < ApplicationRecord
  # Associations
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
