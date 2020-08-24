class Movie
  attr_reader :tmdb_id,
              :title,
              :vote_average,
              :runtime,
              :description

  def initialize(movie_params)
    @movie_params = movie_params
    @tmdb_id = movie_params[:id]
    @title = movie_params[:title]
    @vote_average = movie_params[:vote_average]
    @runtime = movie_params[:runtime]
    @description = movie_params[:overview]
  end

  def genres
    @movie_params[:genres].map do |genre|
      genre[:name]
    end
  end

  def cast_members
    @movie_params[:credits][:cast][0..9].map do |member|
      cast_member_params = {
        name: member[:name],
        character: member[:character]
      }
      CastMember.new(cast_member_params)
    end
  end

  def reviews_count
    @movie_params[:reviews][:total_results]
  end

  def reviews
    @movie_params[:reviews][:results].map do |review|
      review_params = {
        author: review[:author],
        content: review[:content]
      }
      Review.new(review_params)
    end
  end
end
