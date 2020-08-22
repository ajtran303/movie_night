class TheMoviesDataBaseService
  def top_rated_movies
    movies = [
      conn.get('/3/movie/top_rated?page=1'),
      conn.get('/3/movie/top_rated?page=2')
    ]
    movies.sum(&movies_results)
  rescue NoMethodError
    nil
  end

  def find_movies_by_title(keyword)
    movies = [
      conn.get("/3/search/movie?page=1&query=#{keyword}"),
      conn.get("/3/search/movie?page=2&query=#{keyword}")
    ]
    movies.sum(&movies_results)
  rescue NoMethodError
    nil
  end

  private

  def conn
    Faraday.new 'https://api.themoviedb.org' do |f|
      f.params['api_key'] = ENV['TMDB_API_KEY']
      f.headers['Content-Type'] = 'application/json'
    end
  end

  def parse_body(response)
    # JSON.parse(response.body, symbolize_names: true) if valid_json?(response.body)
    # This guard clause initializes the exception handling routine
    # If the Continious Integration checks pass, then we can delete the whole routine.
    JSON.parse(response.body, symbolize_names: true)
  end

  def movies_results
    proc do |movies_response|
      movies = parse_body(movies_response)
      movies[:results] unless movies.nil?
    end
  end

  def valid_json?(string)
    JSON.parse(string)
  rescue JSON::ParserError
    false
  end
end
