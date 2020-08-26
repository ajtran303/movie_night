class PartyInvitee < ApplicationRecord
  validates_presence_of :party_id, :invitee_id

  belongs_to :party
  belongs_to :invitee, class_name: 'User'
end
