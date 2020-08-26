require "rails_helper"

RSpec.describe "Create Viewing Party Spec" do
  describe "As an authenticated user" do
    before :each do
      @user1 = User.create!(oauth_id: "100000000000000000000", name: "John Smith", email: "john@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
      @user2 = User.create!(oauth_id: "100000000000000000001", name: "Jane Doe", email: "jane@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
      Friendship.create_reciprocal_for_ids(@user1.id, @user2.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end
  end
end
