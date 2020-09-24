class DashboardController < ApplicationController
  skip_after_action :ensure_permissions_checked

  def index
    @admin_count = User.all.size
  end
end
