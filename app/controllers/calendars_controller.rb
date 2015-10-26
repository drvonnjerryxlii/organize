class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show]

  def index
    @calendars = Calendar.all
  end

  def show
    @events = prepare_calendar
    # @events = @calendar.ta_events
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
      map.keys.each do |key|
        vacancies.push(Struct.new({
          start_time: key,
          count: map[key]
        }))
      end

      return vacancies
    end
end
