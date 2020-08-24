class Movie
  attr_reader :tmdb_id,
              :title,
              :vote_average,
              :runtime,
              :genres,
              :description,
              :cast_members,
              :reviews_count,
              :reviews

  def initialize(movie_params)
    @tmdb_id = movie_params[:id]
    @title = movie_params[:title]
    @vote_average = movie_params[:vote_average]
    @runtime = movie_params[:runtime]
    @description = movie_params[:overview]
    get_details(movie_params) unless movie_params[:genres].nil?
  end

  def get_genre(movie_params)
    @genres = movie_params[:genres].map do |genre|
      genre[:name]
    end
  end

  def get_cast_members(movie_params)
    @cast_members = movie_params[:credits][:cast][0..9].map do |member|
      cast_member_params = {
        name: member[:name],
        character: member[:character]
      }
      CastMember.new(cast_member_params)
    end
  end

  def get_reviews(movie_params)
    @reviews_count = movie_params[:reviews][:total_results]
    @reviews = movie_params[:reviews][:results].map do |review|
      review_params = {
        author: review[:author],
        content: review[:content]
      }
      Review.new(review_params)
    end
  end

  def get_details(movie_params)
    get_genre(movie_params)
    get_cast_members(movie_params)
    get_reviews(movie_params)
  end
end

class Review
  attr_reader :author,
              :content

  def initialize(review_params)
    @author = review_params[:author]
    @content = review_params[:content]
  end
end

class CastMember
  attr_reader :actor,
              :character

  def initialize(cast_member_params)
    @actor = cast_member_params[:name]
    @character = cast_member_params[:character]
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
