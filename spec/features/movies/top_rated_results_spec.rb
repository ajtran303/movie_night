require "rails_helper"

RSpec.describe "Top Rated Results Spec", :vcr do
  before :each do
    @user = User.create!(oauth_id: "100000000000000000000", name: "John Smith", email: "john@example.com")
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
        expect(page.has_field? :movie_title_keywords ).to be_truthy
        expect(page).to have_button "Find Movies"
      end
    end
  end

  describe "When I click the button to discover top rated movies" do
    it "There are 40 results of Movies" do
      visit movies_path
      click_button "Find Top Rated Movies"
      expect(current_path).to eq("/movies")

      within ".results" do
        expect(page).to have_selector("article[class*=movie]", count: 40)
      end
    end
  end

  # describe "Each movie result has" do
  #   before :each do
  #     visit movies_path
  #
  #     # when this button is clicked,
  #     # it will send an HTTP request to the API service
  #     # The API service will send a response
  #
  #     # we should stub the http request
  #     # and return a movies_mock object
  #
  #     click_button "Find Top Rated Movies"
  #     @movies = movies_mock
  #   end
  #
  #   it "the movie title links to that movie show page and there is vote average" do
  #     within ".results" do
  #       @movies.each do |movie|
  #         expect(page).to have_link(movie.name, href: movie_path(movie))
  #         expect(page).to content("Vote Average: #{movie.vote_average}")
  #       end
  #     end
  #   end
  # end
end
