class CastMember
  attr_reader :actor,
              :character

  def initialize(cast_member_params)
    @actor = cast_member_params[:name]
    @character = cast_member_params[:character]
  end
end
