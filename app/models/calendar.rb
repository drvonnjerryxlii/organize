class Calendar < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  has_and_belongs_to_many :users
  has_and_belongs_to_many :students, association_foreign_key: "user_id"
  has_and_belongs_to_many :volunteers, association_foreign_key: "user_id"
  has_and_belongs_to_many :admin, association_foreign_key: "user_id"
  has_many :events
  has_many :special_conditions

  # Validations ----------------------------------------------------------------
  validates_presence_of :name, :google_calendar_id

  # Scopes ---------------------------------------------------------------------
  # scope :rules, lambda { special_conditions.future }
  # scope :ta_events, lambda { events.ta.future }

  def rules
    special_conditions#.future
  end

  def ta_events
    events.ta#.future
  end
end
