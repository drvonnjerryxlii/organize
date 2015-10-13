class Cohort < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates_presence_of :classroom_start_date, :classroom_end_date,
                        :internship_start_date, :internship_end_date

  # Associations ---------------------------------------------------------------
  has_and_belongs_to_many :users
  has_many :events
end
