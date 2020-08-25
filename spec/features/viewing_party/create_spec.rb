require "rails_helper"

RSpec.describe "Create Viewing Party Spec" do
  describe "As an authenticated user" do
    before :each do
      @user = User.create!(oauth_id: "100000000000000000000", name: "John Smith", email: "john@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      cassette = 'spec/fixtures/vcr_cassettes/Movie_Show_Page/As_an_authenticated_user/I_can_see_movie_details.yml'
      movie_details = File.read(cassette)
      yaml = YAML.load(movie_details, symbolize_names: true)
      json = yaml[:http_interactions][0][:response][:body][:string]
      movie_params = JSON.parse(json, symbolize_names: true)
      @movie = Movie.new(movie_params)
    end

    describe "When I visit the movies details page" do
      it "I can click the button to create a viewing party", :vcr do
        visit("/movies/#{@movie.tmdb_id}")
        click_button "Create A Viewing Party"
        expect(current_path).to eq new_viewing_party_path
      end
    end
  end
end
