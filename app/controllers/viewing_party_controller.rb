class ViewingPartyController < BaseController
  def new
    @movie = SearchResults.movie_details(params[:movie_id])
  end

  def create
    party = Party.new(viewing_party_params)
    create_party(party) if party.valid?
  end

  private

  def create_party(event)
    event.save
    flash[:success] = "You've created a viewing party for #{params[:movie_title]}!"
    redirect_to dashboard_index_path
  end

  def viewing_party_params
    p = params.permit(:movie_title, :party_duration, :date, :time)
    p.merge({ user_id: current_user.id })
  end
end
