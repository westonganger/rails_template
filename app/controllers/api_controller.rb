class ApiController < ActionController::API

  include DeviseTokenAuth::Concerns::SetUserByToken

  ### https://blog.rebased.pl/2016/11/07/api-error-handling.html
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: { message: "422 - Unprocessale Entity", errors: exception.record.errors }, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { message: "404 - Not Found", error: exception.message }, status: :not_found
  end

end
