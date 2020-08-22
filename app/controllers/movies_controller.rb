class MoviesController < BaseController
  def index
    query_params = params[:q] || params[:movie_title_keywords]
    @movies = SearchResults.movies(query_params)
  end
end
