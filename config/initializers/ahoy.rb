class Ahoy::Store < Ahoy::DatabaseStore
end

# set to true for JavaScript tracking
Ahoy.api = false

# better user agent parsing
Ahoy.user_agent_parser = :device_detector

# better bot detection
Ahoy.bot_detection_version = 2

#Ahoy.cookie_domain = :all ### track visits for all sub-domains
Ahoy.quiet = true
Ahoy.track_bots = false
#Ahoy.user_method = :true_user ### for impersonate support

Safely.report_exception_method = ->(e){
  ExceptionNotifier.notify_exception(e, {
    env: request.env,
    data: {}
  })
}

if defined?(Rack::Attack)
  class Rack::Attack

    throttle("ahoy/ip", limit: 20, period: 1.minute) do |req|
      if req.path.start_with?("/ahoy/")
        req.ip
      end
    end

  end
end

# Ahoy.exclude_method = lambda do |controller, request|
#   request.ip == "192.168.1.1"
# end

### For GDPR Compliance
# Ahoy::Store.class_eval do
#   def authenticate(data)
#     # disables automatic linking of visits and users
#   end
# end
# Ahoy.mask_ips = true
# Ahoy.cookies = false
