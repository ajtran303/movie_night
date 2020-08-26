class CreatePartyInvitees < ActiveRecord::Migration[5.2]
  def change
    create_table :party_invitees do |t|
      t.references :party, foreign_key: true
      t.references :invitee

      t.timestamps
    end
  end
end
