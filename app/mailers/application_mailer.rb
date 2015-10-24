class ApplicationMailer < ActionMailer::Base
  default from: "auto-email@voluntearsharks.com" # FIXME: this is a bad address
  layout 'mailer'
end
