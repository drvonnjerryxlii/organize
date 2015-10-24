module GCalV3Wrapper
  class Event
    DEFAULT_TIME_ZONE = "America/Los_Angeles"

    def self.create(params)
      GCalV3Wrapper.require_params([:calendar_id, :event], params)

      authorized_client = Auth.write
      service = authorized_client.discovered_api('calendar', 'v3')

      event = authorized_client.execute(
        :api_method => service.events.insert,
        :parameters => { 'calendarId' => params[:calendar_id] },
        :body => JSON.dump(params[:event]),
        :headers => { 'Content-Type' => 'application/json' }
      )

      return event.data.id
    end

    def self.in_range(params)
      GCalV3Wrapper.require_params([:calendar_id, :time_min, :time_max], params)

      authorized_client = Auth.readonly
      service = authorized_client.discovered_api('calendar', 'v3')

      response = authorized_client.execute(
        :api_method => service.events.list,
        :parameters => {
          'calendarId' => params[:calendar_id],
          'timeMin' => GCalV3Wrapper.to_iso8601(params[:time_min]),
          'timeMax' => GCalV3Wrapper.to_iso8601(params[:time_max]),
          'timeZone' => params[:time_zone] || DEFAULT_TIME_ZONE
        }
      )

      result = response.data.items
      result = result.map do |event|
        {
          id: event.id,
          title: event.summary,
          start_time: event.start.dateTime,
          end_time: event.end.dateTime
        }
      end

      result = result.sort_by { |event| [event[:start_time], event[:end_time]] }

      return result
    end

    def self.today(params)
      GCalV3Wrapper.require_params([:calendar_id], params)

      parameters = {
        calendar_id: params[:calendar_id],
        time_min: Time.parse(Date.today.to_s),
        time_max: Time.parse(Date.tomorrow.to_s)
      }

      return self.in_range(parameters)
    end

    def self.this_week(params)
      GCalV3Wrapper.require_params([:calendar_id], params)

      parameters = {
        calendar_id: params[:calendar_id],
        time_min: Time.parse(Date.today.at_beginning_of_week.to_s), # beginning of week default: Monday
        time_max: Time.parse((Date.today.at_beginning_of_week + 5).to_s) # + 5 days = Saturday midnight
      }

      return self.in_range(parameters)
    end

    def self.month(params) # TODO: document defaults same year as today
      GCalV3Wrapper.require_params([:calendar_id, :month_number], params)

      year = params[:four_digit_year] ? params[:four_digit_year] : Date.today.year
      month = params[:month_number].to_i

      parameters = {
        calendar_id: params[:calendar_id],
        time_min: Time.parse("#{ year }/#{ month }/1"), # eg, start at midnight on 10/1
        time_max: Time.parse("#{ year }/#{ month + 1}/1") # and stop at midnight on 11/1
      }

      return self.in_range(parameters)
    end

    def self.read(params)
      GCalV3Wrapper.require_params([:calendar_id, :event_id], params)

      authorized_client = Auth.readonly
      service = authorized_client.discovered_api('calendar', 'v3')

      response = authorized_client.execute(
        :api_method => service.events.get,
        :parameters => {
          'calendarId' => params[:calender_id],
          'eventId' => params[:event_id]
        }
      )

      result = response.data
      return result
    end

    def self.update(params) # TODO: test
      GCalV3Wrapper.require_params([:calendar_id, :event_id, :event_params], params)

      authorized_client = Auth.write
      service = authorized_client.discovered_api('calendar', 'v3')

      calendar_id = params[:calender_id]
      event_id = params[:event_id]
      update_params = params[:update_params]
      event = result.data
      event.summary = 'Appointment at Somewhere'
      result = authorized_client.execute(
        :api_method => service.events.update,
        :parameters => { 'calendarId' => 'primary', 'eventId' => event.id },
        :body_object => event,
        :headers => { 'Content-Type' => 'application/json' }
      )

      binding.pry
      return result
    end

    def self.move(params) # TODO: test
      GCalV3Wrapper.require_params([:old_calendar_id, :new_calendar_id, :event_id], params)

      authorized_client = Auth.write
      service = authorized_client.discovered_api('calendar', 'v3')

      result = authorized_client.execute(
        :api_method => service.events.move,
        :parameters => {
          'calendarId' => params[:old_calendar_id],
          'eventId' => params[:event_id],
          'destination' => params[:new_calendar_id]
        }
      )

      binding.pry
      return result
    end

    def self.destroy(params) # TODO: test
      GCalV3Wrapper.require_params([:calendar_id, :event_id], params)

      authorized_client = Auth.write
      service = authorized_client.discovered_api('calendar', 'v3')

      result = authorized_client.execute(
        :api_method => service.events.delete,
        :parameters => {
          'calendarId' => params[:calender_id],
          'eventId' => params[:event_id]
        }
      )

      binding.pry
      return result
    end
  end
end
