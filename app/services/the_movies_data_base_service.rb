class TheMoviesDataBaseService
  def top_rated_movies
    movies = [
      conn.get('/3/movie/top_rated?page=1'),
      conn.get('/3/movie/top_rated?page=2')
    ]
    movies.sum(&movies_results)
  end

  def find_movies_by_title(keyword)
    movies = [
      conn.get("/3/search/movie?page=1&query=#{keyword}"),
      conn.get("/3/search/movie?page=2&query=#{keyword}")
    ]
    movies.sum(&movies_results)
  end

  def movie_details(movie_id)
    movie = conn.get "/3/movie/#{movie_id}?&append_to_response=credits,reviews"
    parse_body(movie)
  end

  private

  def conn
    Faraday.new 'https://api.themoviedb.org' do |f|
      f.params['api_key'] = ENV['TMDB_API_KEY']
      f.headers['Content-Type'] = 'application/json'
    end
  end

  def parse_body(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def movies_results
    proc do |movies_response|
      movies = parse_body(movies_response)
      movies[:results]
    end
  end
end
