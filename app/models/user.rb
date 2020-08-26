class User < ApplicationRecord
  validates :oauth_id, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  validates :access_token, presence: true
  validates :refresh_token, presence: true

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :parties
end
