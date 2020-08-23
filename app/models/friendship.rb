class Friendship < ApplicationRecord
  validates :user_id, uniqueness: true, presence: true
  validates :friend_id, uniqueness: true, presence: true

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.create_reciprocal_for_ids(user_id, friend_id)
    user_friendship = Friendship.create(user_id: user_id, friend_id: friend_id)
    friend_friendship = Friendship.create(user_id: friend_id, friend_id: user_id)
  end

  def self.destroy_reciprocal_for_ids(user_id, friend_id)
    friendship1 = Friendship.find_by(user_id: user_id, friend_id: friend_id)
    friendship2 = Friendship.find_by(user_id: friend_id, friend_id: user_id)
    friendship1.destroy
    friendship2.destroy
  end
end
