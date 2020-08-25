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

  describe "Each movie result has", :vcr do
    it "the movie title links to that movie show page and there is vote average" do
      
      visit movies_path
      click_button "Find Top Rated Movies"

      cassette = 'spec/fixtures/vcr_cassettes/Top_Rated_Results_Spec/Each_movie_result_has/the_movie_title_links_to_that_movie_show_page_and_there_is_vote_average.yml'
      fixture = File.read(cassette)
      yaml = YAML.load(fixture, symbolize_names: true)
      yaml_data = yaml[:http_interactions][1][:response][:body][:string]
      json = JSON.parse(yaml_data, symbolize_names: true)
      movies = json[:results].map do |data|
        Movie.new(data)
      end

      movies.each do |movie|
        within(".results") do
          expect(page).to have_link(movie.title, href: "/movies/#{movie.tmdb_id}")
          expect(page).to have_content("Vote Average: #{movie.vote_average}")
        end
      end
    end
  end
end
