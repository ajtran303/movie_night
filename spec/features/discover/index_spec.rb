require "rails_helper"

RSpec.describe "Discover Index Page Spec" do
  describe "As a logged in user" do
    before :each do
      @user = User.create!(oauth_id: "100000000000000000000", name: "John Smith", email: "john@example.com")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I can go to discover index page from the dashboard" do
      visit dashboard_index_path
      within ".discover-movies" do
        click_button "Discover Movies"
      end
      expect(current_path).to eq(discover_index_path)
      expect(page).to have_content("Discover Movies")
    end

    describe "When I visit the discover index page" do
      before :each do
        visit discover_index_path
      end

      it "there is a button to discover top rated movies" do
        within ".top-rated-movies" do
          expect(page).to have_button "Find Top Rated Movies"
        end
      end

      it "there is a text field with a 'Find Movies' button" do
        within ".find-movies" do
          expect(page.has_field? :movie_title_keywords ).to be_truthy
          expect(page).to have_button "Find Movies"
        end
      end
    end
  end
end
