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

  def movies_results
    proc { |json| parse_body(json)[:results] }
  end

  def top_rated_movies
    movies = [
      conn.get('/3/movie/top_rated?page=1'),
      conn.get('/3/movie/top_rated?page=2')
    ]
    movies.sum(&movies_results)
  end
end
