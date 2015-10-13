class Event < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates_presence_of :title, :start_time, :end_time, :google_event_id
  validates :google_event_id, length: { maximum: 1024 }
  validates :cohort_id, numericality: { only_integer: true }, allow_blank: true

  # Associations ---------------------------------------------------------------
  belongs_to :cohort
  belongs_to :guest_lecture
  has_and_belongs_to_many :users
end
