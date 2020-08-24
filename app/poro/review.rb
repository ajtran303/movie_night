class Review
  attr_reader :author,
              :content

  def initialize(review_params)
    @author = review_params[:author]
    @content = review_params[:content]
  end
end
