require "rails_helper"

RSpec.describe "Dashboard Page Viewing Party Section Spec" do
  before :each do
    current_date = DateTime.now.to_date.to_s
    current_time = DateTime.now.to_time.to_s[11..15]
    @user1 = User.create!(oauth_id: "100000000000000000000", name: "John Smith", email: "john@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
    @user2 = User.create!(oauth_id: "100000000000000000002", name: "Jane Bulldozer", email: "jane@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
    @party1 = Party.create!(user: @user1, date: current_date, time: current_time, movie_title: "Resident Evil", party_duration: 180 )
    PartyInvitee.create(party_id: @party1.id, invitee_id: @user2.id)
    @party2 = Party.create!(user: @user2, date: current_date, time: current_time, movie_title: "John Wick 3", party_duration: 200 )
    PartyInvitee.create(party_id: @party2.id, invitee_id: @user1.id)
  end

  scenario "Add to calendar button exists properly" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    visit dashboard_index_path

    within ".viewing-party" do
      within "#party-#{@party1.id}" do
        expect(page).to have_content(@party1.movie_title)
        expect(page).to have_content(@party1.date)
        expect(page).to have_content(@party1.time)
        expect(page).to_not have_button("Add to Calendar")
      end

      within "#party-#{@party2.id}" do
        expect(page).to have_content(@party2.movie_title)
        expect(page).to have_content(@party2.date)
        expect(page).to have_content(@party2.time)
        expect(page).to have_button("Add to Calendar")
      end
    end
  end
end
