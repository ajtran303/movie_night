require "rails_helper"

RSpec.describe CastMember do
  it "exists with attributes" do
    cast_member_params = {name: "AJ", character: "This was good"}
    cast_member = CastMember.new(cast_member_params)
    expect(cast_member.class).to eq(CastMember)
    expect(cast_member.actor).to eq(cast_member_params[:name])
    expect(cast_member.character).to eq(cast_member_params[:character])
  end
end
