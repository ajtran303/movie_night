class MoviesController < ApplicationController
  def index
    @movies = top_rated_movies if params[:q] == 'top rated'
  end

  private

  def conn
    url = 'https://api.themoviedb.org'
    Faraday.new(url) do |f|
      f.params['api_key'] = ENV['TMDB_API_KEY']
    end
  end

  def parse_body(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def top_rated_movies
    response1 = conn.get('/3/movie/top_rated?page=1')
    response2 = conn.get('/3/movie/top_rated?page=2')
    parse_body(response1)[:results] + parse_body(response2)[:results]
  end
end
