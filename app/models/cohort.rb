class Cohort < ActiveRecord::Base
  validates_presence_of :classroom_start_date, :classroom_end_date,
                        :internship_start_date, :internship_end_date
end
