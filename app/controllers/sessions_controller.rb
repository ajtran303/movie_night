class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']

    user = User.find_or_create_by(oauth_id: auth_hash[:uid])
    user.name = auth_hash[:info][:name]
    user.oauth_id = auth_hash[:uid]
    user.email = auth_hash[:info][:email]
    user.access_token = auth_hash[:credentials][:token]
    user.refresh_token = auth_hash[:credentials][:refresh_token]
    user.save

    session[:user_id] = user.id
    redirect_to dashboard_index_path
  end

  def destroy
    session.delete(:user_id)
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_path
    flash[:success] = 'You have successfully logged out'
  end
end
