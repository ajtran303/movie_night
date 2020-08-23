require "rails_helper"

RSpec.describe "As an authenticated user" do
  describe "On Discover Page" do
    before :each do
      @user = User.create!(oauth_id: "100000000000000000000", name: "John Smith", email: "john@example.com")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I can go to movie index page from the discover page" do
      visit discover_index_path
      within ".top-rated-movies" do
        click_button "Find Top Rated Movies"
      end
      expect(current_path).to eq(movies_path)
      expect(page).to have_content("Top Rated Movies")
    end
  end
end
