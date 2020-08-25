require "rails_helper"

RSpec.describe "Create Viewing Party Spec" do
  describe "As an authenticated user" do
    before :each do
      @user1 = User.create!(oauth_id: "100000000000000000000", name: "John Smith", email: "john@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
      @user2 = User.create!(oauth_id: "100000000000000000001", name: "Jane Doe", email: "jane@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
      Friendship.create_reciprocal_for_ids(@user1.id, @user2.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

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

    it "There is a form to create a viewing party" do
      visit("/movies/#{@movie.tmdb_id}")
      click_button "Create A Viewing Party"

      within ".viewing-party-form" do
        expect(page).to have_content(@movie.title)
        expect(page).to have_content(@movie.runtime)

        # When: as a date picker
        # ???

        # Checkboxes next to each friend (if user has friends)
        # expect(page).to have_content(@user2.name)
        # check @user2.name
        # page.check "friend-css-selector" ??

        expect(page).to have_button("Create Party")
      end
    end
  end
end
