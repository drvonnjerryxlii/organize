class SpecialCondition < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  belongs_to :calendar

  # Validations ----------------------------------------------------------------
  validates_presence_of :calendar_id, :new_ta_requirement, :date
  validates_presence_of :calendar

  # Scopes ---------------------------------------------------------------------
  scope :future, -> { where("date > ?", Date.yesterday) }
end
