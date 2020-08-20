class User < ApplicationRecord
  validates :user_id, uniqueness: true, presence: true
  validates :name, presence: true
end
