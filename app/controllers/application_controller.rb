class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :require_login
  before_action :require_admin

  private
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options(options = {})
      { locale: I18n.locale }.merge options
    end

    def set_logged_in_user
      @logged_in_user = User.find_by(id: session[:user_id])
    end

    def set_admin
      @admin = true if @logged_in_user.class == Admin
    end

    def set_broadcasts
      # if no broadcasts or stale broadcasts
      if !session[:broadcasts] || (session[:updated_at] < Date.yesterday.to_s)
        broadcasts = @logged_in_user.broadcasts.active

        # OPTIMIZE: only select desired attributes by chaining scopes or whatevs
        # make a special query to only grab id
        broadcasts = broadcasts.map do |broadcast| # then you can destroy this enumerator
          broadcast.id
        end

        session[:broadcasts] = broadcasts
        session[:updated_at] = Date.today
      end

      @available_broadcast = Broadcast.find(session[:broadcasts].sample)
    end

    def require_login
      set_logged_in_user
      set_admin
      set_broadcasts unless @admin

      unless @logged_in_user
        flash[:error] = I18n.t("errors.require_login")
        session[:return_to] = request.referer # OPTIMIZE: delete this if not using
        redirect_to root_path
      end
    end

    def require_admin
      unless @admin
        if @logged_in_user
          flash[:error] = I18n.t("errors.require_admin")
          redirect_to root_path
        else
          flash[:error] = I18n.t("errors.require_login")
          redirect_to login_path
        end
      end
    end
end
