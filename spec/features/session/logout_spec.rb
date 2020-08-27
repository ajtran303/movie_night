require 'rails_helper'

RSpec.describe 'Logout button' do
  describe 'As an authenticated user' do
    it "can log out" do
      visit root_path
      click_button "Log in with Google"
      expect(current_path).to eq dashboard_index_path
      expect(page).to have_content("Welcome John Smith!")
      click_on "Logout"
      expect(current_path).to eq root_path
      expect(page).to have_content("You have successfully logged out")
      expect(page).to_not have_content("Welcome John Smith")
    end
  end
end
