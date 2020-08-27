class DashboardController < BaseController
  def index
    @parties = Party.all
  end
end
