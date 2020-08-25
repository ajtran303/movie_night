class FriendshipsController < ApplicationController
  def create
    if User.exists?(email: params[:friends_email])
      friend = User.find_by(email: params[:friends_email])
      create_friendship(current_user.id, friend)
    else
      flash[:failure] = 'Email does not exist, please try another one'
    end
    redirect_to dashboard_index_path
  end

  private

  def create_friendship(user_id, friend)
    if friend.id == user_id
      flash[:error] = 'You cannot add yourself as a friend'
    else
      Friendship.create_reciprocal_for_ids(user_id, friend.id)
      flash[:success] = "You are now friends with #{friend.name}"
    end
  end
end
