require "rails_helper"

RSpec.describe Party do
  describe "validations" do
    it { should validate_presence_of :date }
    it { should validate_presence_of :time }
    it { should validate_presence_of :movie_title }
    it { should validate_presence_of :party_duration }
    it { should validate_numericality_of(:party_duration).only_integer }
    it { should validate_numericality_of(:party_duration).is_greater_than(0) }
  end
  describe "associations" do
    it { should belong_to :user }
    it { should have_many :party_invitees }
    it { should have_many(:invitees).through(:party_invitees) }
  end
end
