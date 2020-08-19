require "rails_helper"

RSpec.describe "Create Session with Google OAuth Handshake Spec" do
  describe "As a visitor" do
    describe "On the welcome page" do
      it "I can log in with my Google Account by clicking a button" do
        visit root_path

        expect(User.count).to eq(0)
        click_button "Log in with Google"
        expect(User.count).to eq(1)

        expect(current_path).to eq dashboard_index_path
        expect(page).to have_content("Welcome John Smith!")
      end
    end
  end
end
