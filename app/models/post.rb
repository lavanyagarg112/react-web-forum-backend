class Post < ApplicationRecord
  belongs_to :user
  has_many :tags

  validates :author_name, presence: true
end
