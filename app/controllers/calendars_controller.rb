class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show]

  def index
    @calendars = Calendar.all
  end

  def show
    @events = @calendar.ta_events
    @pending_events = @calendar.events.pending.limit(10).chronological
    @events = @events + @pending_events
    @volunteers = @calendar.volunteers
    @students = @calendar.students
  end

  private

    def set_calendar
      @calendar = Calendar.find(params[:id])
    end
end
