class Party < ApplicationRecord
  validates_presence_of :date, :time, :movie_title, :party_duration
  validates_numericality_of :party_duration, only_integer: true, greater_than: 0
end
