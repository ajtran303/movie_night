class MoviesController < ApplicationController
  def index
    if params[:q] == 'top rated'
      @movies = top_rated_movies
    elsif params["movie-title-keywords"]
      @movies = SearchResults.find_movies(params["movie-title-keywords"])
    end
  end

  class Movie
    attr_reader :id,
                :title,
                :vote_avg
                # :runtime,
                # :genres,
                # :description,
                # :cast_memebers,
                # :reviews_count,
                # :review_author,
                # :review

    def initialize(movie_params)
      @id = movie_params[:id]
      @title = movie_params[:title]
      @vote_avg = movie_params[:vote_average]
      # @runtime
      # @genres
      # @description
      # @cast_memebers
      # @reviews_count
      # @review_author
      # @review
    end
  end

  class SearchResults
    def self.find_movies(keyword)
      service_movie_data.find_movies(keyword).map do |movie_data|
        Movie.new(movie_data)
      end
    end

    def self.service_movie_data
      TMDBService.new
    end
  end

  class TMDBService
    def conn
      Faraday.new "https://api.themoviedb.org" do |f|
        f.params['api_key'] = ENV['TMDB_API_KEY']
        f.headers['Content-Type'] = 'application/json'
      end
    end

    def find_movies(keyword)
      response_1 = conn.get "/3/search/movie" do |r|
        r.params["query"] = keyword
        r.params["page"] = "1"
      end
      response_2 = conn.get "/3/search/movie" do |r|
        r.params["query"] = keyword
        r.params["page"] = "2"
      end

      json_1 = JSON.parse(response_1.body, symbolize_names: true)[:results] if valid_json?(response_1.body)
      json_2 = JSON.parse(response_2.body, symbolize_names: true)[:results] if valid_json?(response_2.body)
      json_1 + json_2
    end

    def valid_json?(string)
      JSON.parse(string)
    rescue JSON::ParserError
      false
    end
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
