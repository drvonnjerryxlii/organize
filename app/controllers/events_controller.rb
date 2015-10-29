class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :approve, :request]
  before_action :set_calendar
  before_action :require_admin, unless: :user_associated?

  def index
    @events = @calendar.events.chronological
  end

  def show; end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  def request_shift
    @event = Event.new(ta_request_params)

    if @event.save
      flash[:success] = "SHIFT REQUESTED YAYZERS" # FIXME: internationalize this
    else
      raise
      flash[:error] = "OH NO SOME ERROR HAPPEN ;_;" # FIXME: internationalize this
    end

    redirect_to calendar_path(@calendar)
  end

  def approve
    if @event.approve
      flash[:success] = "APPROVED" # FIXME: internationalize this
    else
      flash[:error] = "NOT APPROVED SOME ERROR HAPPEN" # FIXME: internationalize this
    end

    redirect_to calendar_path(@calendar)
  end

  def destroy
    @event.destroy
    redirect_to calendar_path(@calendar)
  end

  private
    def set_calendar
      @calendar = Calendar.find(params[:calendar_id])
    end

    def set_event
      @event = Event.find(params[:event_id] || params[:id])
    end

    def ta_request_params
      form = params.require(:event).permit(:date, :start_time, :end_time)

      event = {}
      event[:title] = "TA: #{ @logged_in_user.name }"
      event[:ta] = true
      event[:approved] = false
      event[:user_id] = @logged_in_user.id
      event[:calendar_id] = @calendar.id
      event[:start_time] = Time.parse("#{ form[:date] } #{ form[:start_time] }")
      event[:end_time] = Time.parse("#{ form[:date] } #{ form[:end_time] }")
      event[:admin_only] = false

      return event
    end

    def event_params
      params.require(:event).permit(
        :title,
        :description,
        :location,
        :start_time,
        :end_time,
        :calendar_id,
        :google_event_id,
        :guest_lecture_id,
        :admin_only#,
        # :category_ids => [],
        # :categories_attributes => [:id, :name]
      )
    end

    def user_associated?
      return @calendar.users.include? @logged_in_user
    end
end
