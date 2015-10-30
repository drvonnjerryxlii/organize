class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:login, :create, :oauth]
  skip_before_action :require_admin, only: [:login, :create, :oauth, :logout]

  def login; end

  def create # session, actually logging in
    user = User.find_by(email: params[:session][:email])
    session[:failed_login_attempts] = nil

    if user && user.authenticate(params[:session][:password])
      flash[:success] = I18n.t("success.login", name: user.name)
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:error] = I18n.t("error.login")
      render :login
    end
  end

  def logout
    flash[:success] = I18n.t("success.logout")
    session[:user_id] = nil

    session[:failed_login_attempts] ?
      session[:failed_login_attempts] += 1 :
      session[:failed_login_attempts] = 1

    redirect_to root_path
  end
end
