require "rails_helper"

RSpec.describe "Discover Index Page Spec" do
  describe "As a logged in user" do
    before :each do
      @user = User.create!(user_id: "100000000000000000000", name: "John Smith")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I can go to discover index page from the dashboard" do
      visit dashboard_index_path
      within ".discover-movies" do
        click_button "Discover Movies"
      end
      expect(current_path).to eq(discover_index_path)
    end
  end
end
