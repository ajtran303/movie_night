require "rails_helper"
RSpec.describe "User Dashboard Page" do
  describe "As an authenticated User" do
    before :each do
      @user_1 = User.create!(oauth_id: "100000000000000000000", name: "John Smith", email: "john@example.com")
      @user_2 = User.create!(oauth_id: "100000000000000000001", name: "Jane Doe", email: "jane@example.com")
      @user_3 = User.create!(oauth_id: "100000000000000000002", name: "Sam Smith", email: "sam@example.com")
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
        expect(page).to have_content("Friends")
        expect(page).to have_content(@user_2.name)
      end
    end
    # scenario "I can add a friend by their email address, as long as, the friend is a user of our application and exists in our database" do
    #   visit dashboard_index_path
    #   within(".friends") do
    #     expect(page).to_not have_content(@user_2.name)
    #     expect(page).to_not have_content(@user_3.name)
    #     fill_in :friends_email, with: @user_2.email
    #     click_on "Add Friend"
    #   end
    #   @user_1.reload
    #   friendship = Friendship.first
    #   friendship.reload
    #   expect(current_path).to eq(dashboard_index_path)
    #   expect(page).to have_content("You are now friends with #{@user_2.name}")
    #   within(".friends") do
    #     expect(page).to have_content(@user_2.name)
    #     expect(page).to_not have_content(@user_3.name)
    #   end
    # end
    scenario "I cannot add a friend by their email address if they're not a registered user in the system" do
      visit dashboard_index_path
      within(".friends") do
        fill_in :friends_email, with: "alex@example.com"
        click_on "Add Friend"
      end
      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content("Email does not exist, please try another one")
    end
  end
end
# in the contoller we have to verify that the email is an existing user in the sytem...
# As an authenticated user,
# I see a section for friends,
# In this section, there should be a text field to enter a friend's email and a button to "Add Friend"
#
# Scenarios:
# If I have added friends, I should see a list of all my friends.
#
# Details: Users should be able to add a friend by their email address, as long as, the friend is a user of our application and exists in our database.
#
# Example:
# Bugs Bunny and Lola Bunny are users of our application, but Daffy Duck is not.
#
# When Bugs Bunny enters lola_bunny@gmail.com to add friend it will be successful and Lola should show up as Bugs Bunny's friend.
# When Bugs Bunny enters daffy_duck@gmail.com to add friend it should give an error message that the user does not exist.
# Tips: You'll want to research self-referential has_many through. Here is a good starting point to understand the concept. You will probably need to do more googling but that's part of the fun ;)
#
#  Write a happy path test
#  Write a sad path test
