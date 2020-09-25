module ApplicationHelper
  
  def current_path
    request.env['PATH_INFO']
  end

  def root_path
    if current_user
      dashboard_path
    else
      "/"
    end
  end

  def root_url
    if user_signed_in?
      dashboard_url
    else
      request.url
    end
  end
end
