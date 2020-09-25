class Admin::BaseController < ApplicationController

  before_action :restrict_to_admin

  private

  def restrict_to_admin
    if !current_user.has_role?(:admin)
      raise Error::Unauthorized
    end
  end

end
