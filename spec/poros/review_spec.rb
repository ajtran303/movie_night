require "rails_helper"

RSpec.describe Review do
  it "exists with attributes" do
    review_params = {author: "AJ", content: "This was good"}
    review = Review.new(review_params)
    expect(review.class).to eq(Review)
    expect(review.author).to eq(review_params[:author])
    expect(review.content).to eq(review_params[:content])
  end
end
