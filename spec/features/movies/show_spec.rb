require "rails_helper"

RSpec.describe "Movie Show Page" do
  describe "As an authenticated user" do
    it "I can see movie details", :vcr do
      @user = User.create!(user_id: "100000000000000000000", name: "John Smith")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit movies_path
      click_on "Top Rated"
      click_on "Gabriel's Inferno Part II"
      expect(current_path).to eq('/movies/724089')

      expect(page).to have_content("")
    end
  end
end
