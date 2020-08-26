class ViewingPartyController < BaseController
  def new
    @movie = SearchResults.movie_details(params[:movie_id])
  end

  def create
    party = Party.new(viewing_party_params)
    party.save if party.valid?
  end

  private

  def viewing_party_params
    p = params.permit(:movie_title, :party_duration, :date, :time)
    p.merge({ user_id: current_user.id })
  end
end
