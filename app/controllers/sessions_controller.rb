class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']

    user = User.find_or_create_by(oauth_id: auth_hash[:uid])
    user.name = auth_hash[:info][:name]
    user.oauth_id = auth_hash[:uid]
    user.email = auth_hash[:info][:email]
    user.save

    session[:user_id] = user.id 
    redirect_to dashboard_index_path
  end
end
