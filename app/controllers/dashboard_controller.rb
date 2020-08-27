class DashboardController < BaseController
  def index
    @parties = current_parties
  end

  private

  def current_parties
    current_user.parties + Party.find(PartyInvitee.where(invitee_id: current_user.id).pluck(:party_id))
  end
end
