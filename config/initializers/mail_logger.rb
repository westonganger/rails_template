class LoggerWithFilename < ActiveSupport::Logger

  def initialize(*args)
    @filename = args.first.to_s
    super
  end

  def filename
    @filename
  end

end

MailLogger = LoggerWithFilename.new(Rails.root.join('log/mail.log'), 5, 5.megabyte)
