class ViewingPartyController < BaseController
  def new
    @movie = SearchResults.movie_details(params[:movie_id])
  end

  def create
    party = Party.new(viewing_party_params)
    create_party(party) if party.valid?
  end

  private

  def invite_friends(party)
    friends_ids = params[:invitees][:invitees_id][1..-1]
    friends_ids.each do |friend_id|
      PartyInvitee.create!(party_id: party.id, invitee_id: friend_id.to_i)
    end
  end

  def create_party(event)
    event.save
    invite_friends(event)
    flash[:success] = "You've created a viewing party for #{params[:movie_title]}!"
    redirect_to dashboard_index_path
  end

  def viewing_party_params
    p = params.permit(:movie_title, :party_duration, :date, :time)
    p.merge({ user_id: current_user.id })
  end
end
