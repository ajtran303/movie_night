class MoviesController < ApplicationController
  def index
    @movies = top_rated_movies if params[:q] == 'top rated'
  end

  private

  def conn
    url = 'https://api.themoviedb.org'
    Faraday.new(url) do |f|
      f.params['api_key'] = ENV['TMDB_API_KEY']
      f.headers['Content-Type'] = 'application/json'
    end
  end

  def parse_body(response)
    JSON.parse(response.body, symbolize_names: true) if valid_json?(response.body)
  end

  def valid_json?(string)
    JSON.parse(string)
  rescue JSON::ParserError
    false
  end

  def movies_results
    proc do |movies_response|
      movies = parse_body(movies_response)
      movies[:results] unless movies.nil?
    end
  end

  def top_rated_movies
    movies = [
      conn.get('/3/movie/top_rated?page=1'),
      conn.get('/3/movie/top_rated?page=2')
    ]
    movies.sum(&movies_results)
  rescue NoMethodError
    nil
  end
end
