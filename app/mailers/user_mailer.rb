class UserMailer < ApplicationMailer
  DOMAIN = "voluntearsharks.com"
  default from: "auto-email@#{ DOMAIN }" # FIXME: this is a bad address
 
  def welcome_email(user)
    @user = user
    @url  = "http://#{ domain }/login"
    mail(to: @user.email, subject: "Welcome to Voluntear Shark. The voluntearnado is coming.")
  end
  # TODO:
  # http://guides.rubyonrails.org/action_mailer_basics.html
  # https://blog.engineyard.com/2014/getting-started-with-active-job
end
