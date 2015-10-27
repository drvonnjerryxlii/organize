class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show]

  def index
    @calendars = Calendar.all
  end

  def show
    @events = prepare_calendar
    @students = @calendar.students
  end

  private

    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    def prepare_calendar(calendar=@calendar)
      rules = calendar.rules
      first_day = Date.today.at_beginning_of_month

      map = {}
      ta_events = calendar.ta_events
      ta_events.each do |event|
        day = Date.parse(event.start_time.to_s)
        map[day] ? map[day] += 1 : map[day] = 1
      end

      vacancies = []
      Struct.new("CalEvent", :start_time, :count)
      map.keys.each { |key| vacancies.push(Struct::CalEvent.new(key, map[key])) }

      return vacancies
    end
end
