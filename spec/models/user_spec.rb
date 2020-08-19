require "rails_helper"

RSpec.describe User do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :user_id }
    it { should validate_uniqueness_of :user_id }
  end
end
