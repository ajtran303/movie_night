class PartyInvitee < ApplicationRecord
  validates :party_id, :invitee_id, presence: true

  belongs_to :party
  belongs_to :invitee, class_name: 'User'
end
