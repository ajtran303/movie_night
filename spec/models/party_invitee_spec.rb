require "rails_helper"

RSpec.describe PartyInvitee do
  describe "validations" do
    it { should validate_presence_of :party_id }
    it { should validate_presence_of :invitee_id }
  end
  describe "associations" do
    it { should belong_to :party }
    it { should belong_to(:invitee).class_name('User') }
  end
end
