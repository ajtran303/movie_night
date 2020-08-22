class Movie
  attr_reader :tmdb_id,
              :title,
              :vote_average

  def initialize(movie_params)
    @tmdb_id = movie_params[:id]
    @title = movie_params[:title]
    @vote_average = movie_params[:vote_average]
  end
end

# :runtime,
# :genres,
# :description,
# :cast_memebers,
# :reviews_count,
# :review_author,
# :review
