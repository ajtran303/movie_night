require "rails_helper"

RSpec.describe "Dashboard Page" do
  describe "Authenticated user" do
    before :each do
      @user = User.create!(user_id: "100000000000000000000", name: "John Smith")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "sees a button to discover movies" do
      visit '/dashboard'
      expect(page).to have_content("Welcome John Smith!")
      within(".discover-movies") do
        expect(page).to have_button "Discover Movies"
      end
    end

    it "should have a friends section" do
      visit '/dashboard'
      within(".friends") do
        expect(page).to have_content("Friends")
      end
    end

    it "shoudl have a viewing parties section" do
      visit '/dashboard'
      within(".viewing-party") do
        expect(page).to have_content("Viewing Parties")
      end
    end
  end
end
