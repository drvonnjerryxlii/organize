class Event < ActiveRecord::Base
  validates_presence_of :title, :start_time, :end_time, :google_event_id
  validates :google_event_id, length: { maximum: 1024 }
  validates :cohort_id, numericality: { only_integer: true }, allow_blank: true
end
