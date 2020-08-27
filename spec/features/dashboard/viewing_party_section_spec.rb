require "rails_helper"

RSpec.describe "Dashboard Page Viewing Party Section Spec" do
  before :each do
    @user1 = User.create!(oauth_id: "100000000000000000000", name: "John Smith", email: "john@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    current_date = DateTime.now.to_date.to_s
    current_time = DateTime.now.to_time.to_s[11..15]
    @party1 = Party.create!(user: @user1, date: current_date, time: current_time, movie_title: "Resident Evil", party_duration: 180 )
    @party2 = Party.create!(user: @user1, date: current_date, time: current_time, movie_title: "Resident Evil 2", party_duration: 180 )
    @party3 = Party.create!(user: @user1, date: current_date, time: current_time, movie_title: "Resident Evil 3", party_duration: 180 )
    @parties = [@party1, @party2, @party3]
  end

  describe "As a logged in user on the dashboard page" do
    it "There is a section with all my viewing parties" do
      visit dashboard_index_path

      within ".viewing-party" do
        @parties.each do |party|
          expect(page).to have_content(party.movie_title)
          expect(page).to have_content(party.date)
          expect(page).to have_content(party.time)
          expect(page).to have_button("Add to Calendar")
        end
      end
    end
  end
end
