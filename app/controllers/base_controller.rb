class BaseController < ApplicationController
  before_action :require_user

  private

  def require_user
    render file: '/public/404' if current_user.nil?
  end
end
