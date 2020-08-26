class Party < ApplicationRecord
  validates :date, :time, :movie_title, presence: true
  validates :party_duration, presence: true, numericality: true, only_integer: true, greater_than: 0

  belongs_to :user
  has_many :party_invitees, dependent: :destroy
  has_many :invitees, through: :party_invitees
end
