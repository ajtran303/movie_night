class MoviesController < ApplicationController
  def index
    query_params = params[:q]

    url = "https://api.themoviedb.org"

    conn = Faraday.new(url) do |f|
      f.params["api_key"] = ENV["TMDB_API_KEY"]
    end

    response_1 = conn.get "/3/movie/top_rated?page=1"
    response_2 = conn.get "/3/movie/top_rated?page=2"

    movies_1 = JSON.parse(response_1.body, symbolize_names: true)
    movies_2 = JSON.parse(response_2.body, symbolize_names: true)

    @movies = movies_1[:results] + movies_2[:results]
  end
end
