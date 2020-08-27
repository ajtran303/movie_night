require "rails_helper"

RSpec.describe "Movie Show Page" do
  describe "As an authenticated user" do
    it "I can see movie details", :vcr do
      user = User.create!(oauth_id: "100000000000000000000", name: "John Smith", email: "john@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      cassette = 'spec/fixtures/vcr_cassettes/Movie_Show_Page/As_an_authenticated_user/I_can_see_movie_details.yml'
      movie_details = File.read(cassette)
      yaml = YAML.load(movie_details, symbolize_names: true)
      json = yaml[:http_interactions][0][:response][:body][:string]
      movie_params = JSON.parse(json, symbolize_names: true)
      movie = Movie.new(movie_params)

      visit("/movies/#{movie.tmdb_id}")

      expect(page).to have_content(movie.title)
      expect(page).to have_content(movie.vote_average)
      expect(page).to have_content(movie.runtime)
      expect(page).to have_content(movie.genres.join(', '))
      expect(page).to have_content(movie.cast_members.first.actor)
      expect(page).to have_content(movie.cast_members.first.character)
      expect(page).to have_content(movie.description)
      expect(movie.reviews_count).to have_content(0)
      expect(page).to have_content(movie.reviews_count)
      # expect(page).to have_content(movie.reviews.first.author)
      # expect(page).to have_content(movie.reviews.first.content)
    end
  end
end
