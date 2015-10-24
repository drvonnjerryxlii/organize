FactoryGirl.define do
  factory :event do
    title            "Shark Attack"
    start_time       Time.parse("Oct 8th 2015 11am")
    end_time         Time.parse("Oct 8th 2015 11pm")
    google_event_id  "what a cool, unique id number"
    admin_only       true
    cohort_id        1
    guest_lecture_id 1

    factory :event_without_admin_only do
      admin_only nil
    end
  end
end
