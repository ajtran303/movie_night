require "rails_helper"

RSpec.describe "Discover Movies Page" do
  describe "As an authenticated user" do
    before :each do
      @user = User.create!(user_id: "100000000000000000000", name: "John Smith")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "can search for movies using a keyword" do
      visit discover_index_path
      fill_in "movie-title-keywords", with: "Avengers"
      click_on "Find Movies"
      expect(current_path).to eq("/movies")
      within(".results") do
        expect(page).to have_content("Avengers")
      end
    end
  end
end
