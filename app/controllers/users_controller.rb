class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, unless: :new_account?
  before_action :require_admin, unless: :own_user_content_or_new_account?
  # tried using this pattern https://github.com/rails/rails/issues/9703
  # but ran into override problem like http://stackoverflow.com/questions/4637110/skip-before-filter-ignores-conditionals

  def index
    @admins = Admin.all
    @students = Student.all
    @volunteers = Volunteer.all
  end

  def show; end

  def dashboard; end

  def new
    @user = User.new
  end

  def new_or_edit_oauth
    auth = request.env["omniauth.auth"]
    oauth = Oauth.find_by(provider_uid: auth["uid"], provider: auth["provider"])

    if oauth
      user = User.find_by(id: oauth.user_id)
      session[:user_id] = user.id
      redirect_to root_path
    else # disabling this signup option for now
      # @user = User.new(email: auth["info"]["email"], name: auth["info"]["name"])
      # @user.github = auth["info"]["nickname"] if auth["provider"] == "github"
      # session[:oauth] = { uid: auth["uid"], provider: auth["provider"] }
      # render :new
    end
  end

  def edit; end

  def create
    @user = User.new(user_params)
    @user.type = "Volunteer" if @user.type.nil?

    if @user.save
      if session[:oauth]
        oa = Oauth.create(
          provider_uid: session[:oauth]["uid"],
          provider: session[:oauth]["provider"],
          user_id: @user.id
        )
        session[:oauth] = nil
        session[:user_id] = @user.id
      end

      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      if @admin
        params.require(:user).permit(
          :password_digest,
          :name,
          :email,
          :github,
          :type,
          :category_ids => [],
          :categories_attributes => [:id, :name]
        )
      else
        params.require(:user).permit(
          :password_digest,
          :name,
          :email,
          :github,
          :category_ids => [],
          :categories_attributes => [:id, :name]
        )
      end
    end

    def is_user_logged_in_user?
      @user == @logged_in_user
    end

    def own_user_content?
      actions_permitted_if_user_is_logged_in_user = ["show", "edit", "update"]
      if actions_permitted_if_user_is_logged_in_user.include? params[:action]
        return is_user_logged_in_user?
      end
    end

    def new_account? # require login if not true
      actions_permitted_if_user_is_creating_account = ["new_or_edit_oauth", "create"]
      if actions_permitted_if_user_is_creating_account.include? params[:action]
        return session[:user_id] ? false : true # return false if user is logged in
      else
        return false
      end
    end

    def own_user_content_or_new_account?
      return own_user_content? || new_account?
    end
end
