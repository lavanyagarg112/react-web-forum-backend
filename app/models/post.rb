class Post < ApplicationRecord
  belongs_to :user
  belongs_to :user_datum
  has_many :tags
end
