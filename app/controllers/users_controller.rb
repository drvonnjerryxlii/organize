class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, unless: :own_user_content?
  # tried using this pattern https://github.com/rails/rails/issues/9703
  # but ran into override problem like http://stackoverflow.com/questions/4637110/skip-before-filter-ignores-conditionals

  def index
    @users = User.all
  end

  def show; end

  def dashboard; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
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
          :type,
          :category_ids => [],
          :categories_attributes => [:id, :name]
        )
      elsif @logged_in_user
        params.require(:user).permit(
          :password_digest,
          :name,
          :email,
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
end
