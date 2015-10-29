require "#{ Rails.root }/lib/gcal_v3_wrapper"

class Event < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  belongs_to :calendar # calendars_users join table to store viewing permissions?
  belongs_to :guest_lecture
  belongs_to :user
  has_and_belongs_to_many :users

  # Callbacks ------------------------------------------------------------------
  after_create :create_gcal_event
  before_update :move_gcal_event, if: :calendar_id_changed?
  after_update :update_gcal_event
  before_destroy :destroy_gcal_event

  # Validations ----------------------------------------------------------------
  validates_presence_of :title, :start_time, :end_time, :calendar_id
  validates_presence_of :calendar
  validates :google_event_id, length: { maximum: 1024 }, allow_blank: true
  validates :calendar_id, numericality: { only_integer: true }
  validate :start_time_must_be_before_end_time

  # Scopes ---------------------------------------------------------------------
  scope :approved, -> { where(approved: true) }
  scope :pending, -> { where(approved: false) }
  scope :ta, -> { approved.where(ta: true) }
  scope :gl, -> { approved.where(gl: true) }

  scope :in_range, lambda { |date1, date2|
    where("start_time BETWEEN ? AND ?", date1, date2)
  }

  scope :month, lambda { |m = Time.now.month, yyyy = Time.now.year|
    in_range(Time.parse("#{ yyyy }/#{ m }/1"), Time.parse("#{ yyyy }/#{ m + 1 }/1"))
  }

  scope :today, -> { in_range(Time.parse(Date.today.to_s), Time.parse(Date.tomorrow.to_s)) }
  # scope :today, -> { where("? BETWEEN start_time AND end_time", Date.today) }
  # scope :this_month -> { where("start_time BETWEEN ? AND ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month) }
  scope :future, -> { where("start_time > ?", Date.yesterday) }
  scope :chronological, -> { order(:start_time) } # this should happen last, because expensive

  DEFAULT_ADDRESS = "1215 4th Ave #1050, Seattle, WA 98161"

  def approve
    event = event_params
    event['attendees'] = [{ 'email' => user.email }]

    notify = true
    if update_gcal_event(event, notify)
      update_column(:approved, true)
    else
      errors.add(:approved, "oops something went wrong what happen bro") # FIXME: internationalize this error
    end
  end

  private
    def create_gcal_event
      google_id = GCalV3Wrapper::Event.create({
        calendar_id: calendar.google_calendar_id,
        event: event_params
      })

      self.update_column(:google_event_id, google_id)
    end

    def update_gcal_event(event=event_params, notify=false)
      GCalV3Wrapper::Event.update({
        calendar_id: calendar.google_calendar_id,
        event_id: google_event_id,
        sendNotifications: notify,
        event: event
      })
    end

    def destroy_gcal_event
      result = GCalV3Wrapper::Event.destroy({
        calendar_id: calendar.google_calendar_id,
        event_id: google_event_id
      })

      return result
    end

    def move_gcal_event
      changes = self.changes[:calendar_id]
      old_calendar_id = changes[0]
      new_calendar_id = changes[1]

      old_gcal_id = Calendar.find(old_calendar_id).google_calendar_id
      new_gcal_id = Calendar.find(new_calendar_id).google_calendar_id

      result = GCalV3Wrapper::Event.move({
        old_calendar_id: old_gcal_id,
        new_calendar_id: new_gcal_id,
        event_id: self.google_event_id
      })

      return result
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

    def start_time_must_be_before_end_time
      unless start_time < end_time
        errors.add(:start_time, "must be before end time") # FIXME: internationalize this error
      end
    end
end
