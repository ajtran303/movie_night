require "rails_helper"

RSpec.describe "Welcome Index Page" do
  it "exists" do
    visit root_path
    expect(page).to have_content("Viewing party is an application in which users can explore movie options and create a viewing party event for the user and friend's.")
  end
end
