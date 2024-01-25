# app/models/comment.rb
class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  # Validations
  validates :content, presence: true

  # Method to retrieve nested replies with their replies (recursively)
  def nested_replies
    replies.map do |reply|
      reply.as_json.merge(replies: reply.nested_replies)
    end
  end
end
