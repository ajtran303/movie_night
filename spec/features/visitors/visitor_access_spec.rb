require "rails_helper"

RSpec.describe "Limit visitor access to pages" do
  describe "As a visior" do
    it "cannot see the dashboard page unless logged in" do
      visit dashboard_index_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "cannot see the discover index page unless logged in" do
      visit discover_index_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "cannot see the movies page unless logged in" do
      visit movies_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
