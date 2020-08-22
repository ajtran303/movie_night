class BaseController < ApplicationController

  before_action :require_user

  private
  def require_user
    if current_user.nil?
      render file: "/public/404"
    end
  end
end
