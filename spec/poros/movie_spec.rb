require "rails_helper"

RSpec.describe Movie do
  it "exists with attributes" do
    cassette = 'spec/fixtures/vcr_cassettes/Movie_Show_Page/As_an_authenticated_user/I_can_see_movie_details.yml'
    movie_details = File.read(cassette)
    yaml = YAML.load(movie_details, symbolize_names: true)
    json = yaml[:http_interactions][0][:response][:body][:string]
    movie_params = JSON.parse(json, symbolize_names: true)
    movie = Movie.new(movie_params)

    expect(movie.class).to eq(Movie)

    expect(movie.cast_members.class).to eq(Array)
    expect(movie.description.class).to eq(String)
    expect(movie.genres.class).to eq(Array)
    expect(movie.reviews.class).to eq(Array)
    expect(movie.reviews_count.class).to eq(Integer)
    expect(movie.runtime.class).to eq(Integer)
    expect(movie.title.class).to eq(String)
    expect(movie.tmdb_id.class).to eq(Integer)
    expect(movie.vote_average.class).to eq(Float)
  end
end
