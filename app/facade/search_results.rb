class SearchResults
  def self.find_movies(keyword)
    service_movie_data.find_movies(keyword).map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def self.top_rated_movies
    service_movie_data.top_rated_movies.map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def self.service_movie_data
    TheMoviesDataBaseService.new
  end
end
