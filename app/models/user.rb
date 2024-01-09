class User < ApplicationRecord

  has_many :posts

  has_one :user_datum, dependent: :destroy, class_name: 'UserDatum'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_user_datum

  def user_datum
    super || build_user_datum(authorname: self.username)
  end

  private

  def create_user_datum
    build_user_datum(authorname: self.username).save
  end



end
