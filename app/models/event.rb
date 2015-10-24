require "#{ Rails.root }/lib/gcal_v3_wrapper"

class Event < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  belongs_to :calendar # calendars_users join table to store viewing permissions?
  belongs_to :guest_lecture
  has_and_belongs_to_many :users

  # Callbacks ------------------------------------------------------------------
  after_create :create_google_event
  after_update :update_google_event

  # Validations ----------------------------------------------------------------
  validates_presence_of :title, :start_time, :end_time, :calendar_id
  validates :google_event_id, length: { maximum: 1024 }, allow_blank: true
  validates :calendar_id, numericality: { only_integer: true }

  DEFAULT_ADDRESS = "1215 4th Ave #1050, Seattle, WA 98161"

  private
    def create_google_event
      google_id = GCalV3Wrapper::Event.create({
        calendar_id: calendar.google_calendar_id,
        event: event_params
      })

      self.update_column(:google_event_id, google_id)
    end

    def update_google_event
      GCalV3Wrapper::Event.update({
        calendar_id: calendar.google_calendar_id,
        event_id: google_event_id,
        event: event_params
      })
    end

    def destroy_google_event
      GCalV3Wrapper::Event.destroy({
        calendar_id: calendar.google_calendar_id,
        event_id: google_event_id
      })
    end

    def event_params
      {
        'summary' => title,
        'description' => description,
        'location' => location || DEFAULT_ADDRESS,
        'start' => { 'dateTime' => GCalV3Wrapper.to_iso8601(start_time) },
        'end' => { 'dateTime' => GCalV3Wrapper.to_iso8601(end_time) }
      }
    end
end
