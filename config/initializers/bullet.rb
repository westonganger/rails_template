if defined?(Bullet) && Rails.env.development?
  Rails.application.configure do
    config.after_initialize do
      Bullet.enable = true
      Bullet.add_footer = true
      Bullet.rails_logger = true
    end
  end
end
