class User < ApplicationRecord
  validates :oauth_id, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
end
