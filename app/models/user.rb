# app/models/user.rb
class User < ApplicationRecord
  # Associations
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :user_datum, dependent: :destroy, class_name: 'UserDatum'

  # Devise Configuration
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Callbacks
  after_create :create_user_datum

  # Methods

  # allows accessing the associated user data, ensuring that it's always available or created with the 
  # username when accessing it.
  def user_datum
    super || build_user_datum(authorname: self.username)
  end

  private

  # used to create and save the associated user data when a new user is created
  def create_user_datum
    build_user_datum(authorname: self.username).save
  end
end
