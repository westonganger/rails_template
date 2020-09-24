class ExceptionsController < ActionController::Base

  def show
    request.format = :html

    render "errors/#{@rescue_response}", status: @status_code
  end

  rescue_from Exception do |exception|
    if defined?(ExceptionRecord)
      ExceptionRecord.create!(
        title: exception.message,
        content: exception.full_message,
      )
    end

    if !Rails.env.production?
      raise exception
    else
      unless exception.is_a?(ActionController::InvalidAuthenticityToken)
        ExceptionNotifier.notify_exception(exception, {
          env: request.env, 
          data: {
            msg: "An exception occurred within #{Rails.application.class.parent.name}"
          }
        })
      end

      logger.error exception
      exception.backtrace.each{|line| logger.error line }

      flash_message = 'Sorry. An error occured. The administrator has been notified.'

      if request.format == 'js'
        flash[:alert] = flash_message
        flash.keep(:alert)
        render js: "window.location = window.location;"
      else
        redirect_to root_path, alert: flash_message
      end
    end
  end

end
