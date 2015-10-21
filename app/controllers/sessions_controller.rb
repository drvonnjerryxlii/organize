class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:login, :create]
  skip_before_action :require_admin, only: [:login, :create, :logout]

  def login; end

  def create # session, actually logging in
    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      flash[:error] = "WELCOME, #{ user.name }" # FIXME: internationalize
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:error] = "Invalid username or password. Please try again." # FIXME: internationalize
      render :login
    end
  end

  def oauth
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    flash[:success] = "You've been signed in, #{ user.name }!"
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
