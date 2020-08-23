class User < ApplicationRecord
  validates :user_id, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
end
