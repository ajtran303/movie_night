require "rails_helper"

RSpec.describe "Create Viewing Party Spec", :vcr, :new_episodes => true do
  describe "As an authenticated user" do
    before :each do
      cassette = 'spec/fixtures/vcr_cassettes/New_Viewing_Party_Page.yml'
      movie_details = File.read(cassette)
      yaml = YAML.load(movie_details, symbolize_names: true)
      json = yaml[:http_interactions][0][:response][:body][:string]
      movie_params = JSON.parse(json, symbolize_names: true)
      @movie = Movie.new(movie_params)


      @user1 = User.create!(oauth_id: "100000000000000000000", name: "John Smith", email: "john@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
      @user2 = User.create!(oauth_id: "100000000000000000001", name: "Jane Doe", email: "jane@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
      Friendship.create_reciprocal_for_ids(@user1.id, @user2.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit discover_index_path
      within ".find-movies" do
        fill_in :movie_title_keywords, with: "Buffy"
        click_on "Find Movies"
      end

      VCR.use_cassette('Buffy Show Page') do
        within ".results" do
          movie = page.first(:xpath, '//article')
          movie_link = movie.find_link.text
          click_on movie_link
        end
      end

      VCR.use_cassette('New Viewing Party Page') do
        within ".movie-details" do
          click_on "Create A Viewing Party"
        end
      end
    end

    scenario "There is a form to create a viewing party" do
      expect(Party.all.size).to eq(0)

      within ".new-viewing-party-form" do
        expect(page).to have_content(@movie.title)
        expect(find_field(:party_duration).value).to eq("#{@movie.runtime}")
        page.find(:xpath, '//input[@id="date"]').set(DateTime.now.to_date.to_s)
        page.find(:xpath, '//input[@id="time"]').set(DateTime.now.to_time.to_s[11..15])
        check "Jane Doe"
        click_on "Create Party"
      end

      expect(Party.all.size).to eq(1)

      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content("You've created a viewing party for #{@movie.title}!")
    end
  end
end
