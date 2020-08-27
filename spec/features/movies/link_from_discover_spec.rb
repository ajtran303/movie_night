require "rails_helper"

RSpec.describe "As an authenticated user" do
  describe "On Discover Page" do
    it "I can go to movie index page from the discover page", :vcr do
      @user = User.create!(oauth_id: "100000000000000000000", name: "John Smith", email: "john@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit discover_index_path
      within ".top-rated-movies" do
        click_button "Find Top Rated Movies"
      end
      expect(current_path).to eq(movies_path)
      expect(page).to have_content("Top Rated Movies")
    end
  end
end
