class User < ApplicationRecord
  validates :user_id, uniqueness: true, presence: true
  validates_presence_of :name
end
