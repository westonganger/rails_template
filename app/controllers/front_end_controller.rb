class FrontEndController < BaseController

  layout "front_end"

  def index
  end

  def robots
    render 'robots.txt', layout: false, content_type: 'text/plain'
  end

end
