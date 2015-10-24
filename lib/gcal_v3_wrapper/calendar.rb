module GCalV3Wrapper
  class Calendar
    def self.all
      authorized_client = Auth.readonly
      service = authorized_client.discovered_api('calendar', 'v3')

      response = authorized_client.execute(
        :api_method => service.calendar_list.list
      )

      result = JSON.parse(response.body)["items"]
      result = result.map { |c| { id: c["id"], name: c["summary"], }}

      return result
      # [{:id=>"0qr050pqdb2v1aegceoirnneg4@group.calendar.google.com", :name=>"fake c[1] calendar"},
      # {:id=>"0ti40j2431174k5gnk4c0uabt4@group.calendar.google.com", :name=>"fake c[0] calender"},
      # {:id=>"sqfeh02bds3s0oc5pi8ih8utds@group.calendar.google.com", :name=>"fake c[2] calendar"}]

    end

    def self.create
      # returns calendar id
      raise NotImplementedError, "Calendar#create is not a supported method, because Google Calender API v3 does not support services accounts creating calendars."

      # At this time, the Calendar API v3 does support creating calendars for
      # services credentials. An access token from a web application oauth
      # request must be used for creating calendars on specific accounts.

      # authorized_client = Auth.write
      # service = authorized_client.discovered_api('calendar', 'v3')
      #
      # calendar = {
      #   'summary' => "calendarSummary",
      #   'timeZone' => "America/Los_Angeles"
      # }
      #
      # result = authorized_client.execute(
      #   :api_method => service.calendars.insert(),
      #   :parameters => calendar
      # )
      #

      # calendar.calendars.insert executed moments ago time to execute: 1287 ms

      # Request
      # =======
      # POST https://www.googleapis.com/calendar/v3/calendars
      # {
      #  "summary": "sdafasdfasdf"
      # }

      # Response
      # ========
      # 200 OK
      # - SHOW HEADERS -
      # {
      #
      #  "kind": "calendar#calendar",
      #  "etag": "\"wPB4sv3SXX_TNjlIyBWrKwcZTHg/7xbunbRpUXkRhUEvWWlRu58-_14\"",
      #  "id": "ihatpsj9ogp437cu9m1frek1t0@group.calendar.google.com",
      #  "summary": "sdafasdfasdf"
      # }
    end

    def self.read(options_hash) # takes in date range? defaults to what?
      calendar_id = options_hash[:calender_id]

      # returns x events?
    end

    def self.in_range(options_hash)
      calendar_id = options_hash[:calender_id]
      start_time = options_hash[:start_time]
      end_time = options_hash[:end_time]
      page = options_hash[:page] || 1

      # returns list of events
    end


    def self.today(options_hash)
      calendar_id = options_hash[:calender_id]

      # returns today's events?
    end

    def self.this_month(options_hash)
      calendar_id = options_hash[:calender_id]

      # returns all events this month (this 4wk per?)
    end

    def self.update(options_hash)
      calendar_id = options_hash[:calender_id]
      update_params = options_hash[:update_params]

      # returns updated calendar?
    end

    def self.destroy(options_hash)
      calendar_id = options_hash[:calender_id]

      # returns true/false?
      # super confirm?
      # not event write?
    end
  end
end
