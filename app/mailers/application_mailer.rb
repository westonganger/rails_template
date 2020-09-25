class ApplicationMailer < ActionMailer::Base
  default from: SITE_DATA[:email_from]

  layout 'mailer'
end
