class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
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

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private
    def set_event
      @event = Event.find(params[:id])
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
        :admin_only,
        :category_ids => [],
        :categories_attributes => [:id, :name]
      )
    end
end
