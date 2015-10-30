class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show]
  before_action :require_admin, unless: :user_associated_and_allowed_action?


  def index
    if @admin
      @calendars = Calendar.all
    else
      @calendars = @logged_in_user.calendars
    end
  end

  def show
    @events = @calendar.ta_events
    @pending_events = @calendar.events.pending.limit(10).chronological
    @events = @events + @pending_events
    @students = @calendar.students
    @volunteers = @calendar.volunteers if @admin
    @event = Event.new
  end

  private

    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    def user_associated?
      if params[:action] == "index"
        return @logged_in_user.calendars.count > 0
      elsif params[:action] == "show"
        return @calendar.users.include? @logged_in_user
      end
    end

    def user_associated_and_allowed_action?
      allowed_actions = ["index", "show"]
      return user_associated? if allowed_actions.include? params[:action]
    end
end
