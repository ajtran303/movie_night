require "rails_helper"

RSpec.describe "Top Rated Results Spec" do
  before :each do
    @user = User.create!(user_id: "100000000000000000000", name: "John Smith")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe "As an authorized user on the Movies Results Index page" do
    before :each do
      visit movies_path
    end

    it "There is a button to discover top rated movies" do
      within ".top-rated-movies" do
        expect(page).to have_button "Find Top Rated Movies"
      end
    end

    it "a text field with a 'Find Movies' button" do
      within ".find-movies" do
        expect(page.has_field? "movie-title-keywords").to be_truthy
        expect(page).to have_button "Find Movies"
      end
    end
  end

  describe "When I click the button to discover top rated movies" do
    it "There are 40 results of Movies" do
      visit movies_path
      click_button "Find Top Rated Movies"
      expect(current_path).to eq("/movies?q=top+rated")

      within ".results" do
        expect(page).to have_selector("article[class*=movie]", count: 40)
      end
    end
  end

  # describe "Each movie result has" do
  #   it "the movie titles as links to that movie show page" do
  #   end
  #   it "vote average rating for that movie" do
  #   end
  # end
  
end
