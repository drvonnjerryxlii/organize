class Event < ActiveRecord::Base
  validates_presence_of :title, :start_time, :end_time, :google_event_id
end
