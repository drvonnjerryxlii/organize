class GuestLecturesController < ApplicationController
  before_action :set_guest_lecture, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, unless: :own_user_content?

  def index
    if @logged_in_user.class == Admin
      @guest_lectures = GuestLecture.all
    else
      @guest_lectures = @logged_in_user.guest_lectures
    end
  end

  def show; end

  def new
    @guest_lecture = GuestLecture.new
  end

  def edit; end

  def create
    only_guest_lecture_params = extract_guest_lecture_params
    @guest_lecture = GuestLecture.new(only_guest_lecture_params)

    if @guest_lecture.save
      @guest_lecture.update(guest_lecture_params) # FIXME: error handling
      redirect_to @guest_lecture
    else
      render :new
    end
  end

  def update
    if @guest_lecture.update(guest_lecture_params)
      redirect_to @guest_lecture
    else
      render :edit
    end
  end

  def destroy
    @guest_lecture.destroy
    redirect_to guest_lectures_path
  end

  private
    def set_guest_lecture
      @guest_lecture = GuestLecture.find(params[:id])
    end

    def extract_guest_lecture_params
      only_guest_lecture_params = guest_lecture_params.deep_dup
      only_guest_lecture_params.delete(:category_ids)
      only_guest_lecture_params.delete(:categories_attributes)

      return only_guest_lecture_params
    end

    def guest_lecture_params
      lecture = params.require(:guest_lecture).permit(
        :title,
        :description,
        :category_ids => [],
        :categories_attributes => [:id, :name]
      )
      lecture[:user_id] = @logged_in_user.id
      return lecture
    end

    def is_logged_in_user_owner?
      @guest_lecture.user_id == @logged_in_user.id
    end

    def own_user_content?
      actions_permitted_if_user = ["index", "new", "create"]
      actions_permitted_if_user_is_owner = ["show", "edit", "update", "destroy"]

      if actions_permitted_if_user_is_owner.include? params[:action]
        return is_logged_in_user_owner?
      else
        return actions_permitted_if_user.include? params[:action]
      end
    end
end
