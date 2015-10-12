FactoryGirl.define do
  factory :user do
    password_digest "legit password"
    name "Dr. Shark, MD, DDS, PhD"
    email "dr.shark#{ rand(1000) }@weloveteeth.com"
    type "Volunteer"

    factory :volunteer do
      type "Volunteer"
    end

    factory :admin do
      type "Admin"
    end

    factory :student do
      type "Student"
    end
  end
end
