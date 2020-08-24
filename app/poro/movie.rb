class Movie
  attr_reader :tmdb_id,
              :title,
              :vote_average
              # :runtime,
              # :genres,
              # :description,
              # :cast_members, #array of [member_1, member_2]
              # :reviews_count,
              # :reviews

  def initialize(movie_params)
    @tmdb_id = movie_params[:id]
    @title = movie_params[:title]
    @vote_average = movie_params[:vote_average]
    # @runtime = movie_params[:runtime]
    # @genres = movie_params[:genres]
    # @description = movie_params[:overview]
    # @cast_members = movie_params[:cast_members]
    # @reviews_count = movie_params[:reviews_count]
    # @review_author = movie_params[:review_author]
    # @review_info = movie_params[:review_info]
  end
end

# :runtime, json[:runtime]
# :genres, json[:genres]
# :description, json[:overview]
# :cast_members,  json[:credits][:cast][0..9] itereate name
# :cast_roles,  json[:credits][:cast][0..9] itereate character
# :reviews_count, json[:reviews][:total_results]
# :review_author, json[:reviews][:results][0][:author]
# :review json[:reviews][:results][0][:content]
