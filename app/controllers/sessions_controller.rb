class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:login, :create, :oauth]
  skip_before_action :require_admin, only: [:login, :create, :oauth, :logout]

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

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
