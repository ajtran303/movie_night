class Party < ApplicationRecord
  validates_presence_of :date, :time, :movie_title, :party_duration
  validates_numericality_of :party_duration, only_integer: true, greater_than: 0

  belongs_to :user
  has_many :party_invitees
  has_many :invitees, through: :party_invitees
end
