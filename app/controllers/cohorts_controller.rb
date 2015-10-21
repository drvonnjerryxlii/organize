class CohortsController < ApplicationController
  before_action :set_cohort, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, unless: :logged_in_user_associated?
  before_action :fix_cohort, only: :index

  def index
    @cohorts = Cohort.all if @logged_in_user.class == Admin
  end

  def show; end

  def new
    @cohort = Cohort.new
  end

  def edit; end

  def create
    only_cohort_params = extract_cohort_params
    @cohort = Cohort.new(only_cohort_params)

    if @cohort.save
      @cohort.update(cohort_params) # FIXME: error handling
      redirect_to @cohort
    else
      render :new
    end
  end

  def update
    if @cohort.update(cohort_params)
      redirect_to @cohort
    else
      render :edit
    end
  end

  def destroy
    @cohort.destroy
    redirect_to cohorts_path
  end

  private
    def set_cohort
      @cohort = Cohort.find(params[:id])
    end

    def extract_cohort_params
      only_cohort_params = cohort_params.deep_dup
      only_cohort_params.delete(:category_ids)
      only_cohort_params.delete(:categories_attributes)

      return only_cohort_params
    end

    def cohort_params
      params.require(:cohort).permit(
        :classroom_start_date,
        :classroom_end_date,
        :internship_start_date,
        :internship_end_date,
        :category_ids => [],
        :categories_attributes => [:id, :name]
      )
    end

    def fix_cohort
      @cohorts = @logged_in_user.cohorts if @logged_in_user.class != Admin
    end

    def logged_in_user_associated?
      actions_permitted_if_user_is_logged_in_user = ["show", "edit", "update", "destroy"]
      if actions_permitted_if_user_is_logged_in_user.include? params[:action]
        return @cohort.users.include? @logged_in_user
      else
        return true
      end
    end
end
