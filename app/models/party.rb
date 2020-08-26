class Party < ApplicationRecord
  validates :date, :time, :movie_title, :party_duration, presence: true
  validates_numericality_of :party_duration, only_integer: true, greater_than: 0

  belongs_to :user
  has_many :party_invitees, dependent: :destroy
  has_many :invitees, through: :party_invitees
end
