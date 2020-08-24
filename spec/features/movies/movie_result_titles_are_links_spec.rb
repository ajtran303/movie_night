require "rails_helper"

RSpec.describe "Movie title links" do
  describe "As an authenticated user" do
    before :each do
      @user = User.create!(user_id: "100000000000000000000", name: "John Smith")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    describe "Movies index page" do
      it "has links to the movie's show page from top rated query" do
        visit movies_path
        click_on "Top Rated"
        within(first(".movie")) do
          expect(page).to have_link("Gabriel's Inferno Part II", href: '/movies/724089')
        end
      end

      it "has links to the movie's show page from search query" do
        visit movies_path
        fill_in :movie_title_keywords, with: "Avengers"
        click_on "Find Movies"
        within(first(".movie")) do
          expect(page).to have_link("Avengers: Infinity War", href: '/movies/299536')
        end
      end
    end
  end
end
