FactoryGirl.define do
  factory :cohort do
    name "legit cohort name"
    classroom_start_date "2015-05-04 08:58:34"
    classroom_end_date "2015-11-23 17:01:34"
    internship_start_date "2015-11-30 08:00:34"
    internship_end_date "2016-04-28 17:55:34"
    google_calendar_id "totally legit calendar id"

    factory :cohort_without_google_calendar_id do
      google_calendar_id nil
    end
  end
end
