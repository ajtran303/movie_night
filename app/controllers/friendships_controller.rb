class FriendshipsController < ApplicationController
  def create
    if User.exists?(email: params[:friends_email])
      friend = User.find_by(email: params[:friends_email])
      Friendship.create_reciprocal_for_ids(current_user.id, friend.id)
      flash[:success] = "You are now friends with #{friend.name}"
    else
      flash[:failure] = "Email does not exist, please try another one"
    end
    redirect_to dashboard_index_path
  end
end
