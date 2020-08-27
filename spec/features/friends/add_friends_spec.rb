require "rails_helper"
RSpec.describe "User Dashboard Page" do
  describe "As an authenticated User" do
    before :each do
      @user_1 = User.create!(oauth_id: "100000000000000000000", name: "John Smith", email: "john@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
      @user_2 = User.create!(oauth_id: "100000000000000000001", name: "Jane Doe", email: "jane@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
      @user_3 = User.create!(oauth_id: "100000000000000000002", name: "Sam Smith", email: "sam@example.com", access_token: "TOKEN", refresh_token: "REFRESH_TOKEN")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    end

    scenario "with no friends" do
      visit dashboard_index_path
      within(".friends") do
        expect(page).to have_content("Friends")
        expect(page).to have_content("You currently have no friends")
      end
    end

    scenario "with friends" do
      Friendship.create_reciprocal_for_ids(@user_1.id, @user_2.id)
      visit dashboard_index_path
      within(".friends") do
        expect(page).to_not have_content("You currently have no friends")
        expect(page).to have_content("Friends")
        expect(page).to have_content(@user_2.name)
      end
    end

    scenario "I can add a friend by their email address, as long as, the friend is a user of our application and exists in our database" do
      visit dashboard_index_path
      within(".friends") do
        expect(page).to_not have_content(@user_2.name)
        expect(page).to_not have_content(@user_3.name)
        fill_in :friends_email, with: @user_2.email
        click_on "Add Friend"
      end
      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content("You are now friends with #{@user_2.name}")
      within(".friends") do
        expect(page).to_not have_content("You currently have no friends")
        expect(page).to have_content(@user_2.name)
        expect(page).to_not have_content(@user_3.name)
      end
    end

    scenario "I cannot add a friend by their email address if they're not a registered user in the system" do
      visit dashboard_index_path
      within(".friends") do
        fill_in :friends_email, with: "alex@example.com"
        click_on "Add Friend"
      end
      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content("Email does not exist, please try another one")
    end

    scenario "Users cannot add themselves as friends" do
      visit dashboard_index_path
      within(".friends") do
        fill_in :friends_email, with: "john@example.com"
        click_on "Add Friend"
      end
      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content("You cannot add yourself as a friend")
    end
  end
end
