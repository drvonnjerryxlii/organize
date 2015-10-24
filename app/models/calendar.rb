class Calendar < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  has_and_belongs_to_many :users
  has_many :events

  # Validations ----------------------------------------------------------------
  validates_presence_of :name, :google_calendar_id
end
