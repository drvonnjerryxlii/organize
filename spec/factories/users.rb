FactoryGirl.define do
  factory :user do |user|
    user.password_digest "legit password"
    user.name "Dr. Shark, MD, DDS, PhD"
    user.sequence(:email) { |n| "dr.shark#{ n }@weloveteeth.com" }
    user.type "Volunteer"
  end

  factory :volunteer do |user|
    user.password_digest "legit password"
    user.name "Dr. Shark, MD, DDS, PhD"
    user.sequence(:email) { |n| "dr.shark#{ n }@weloveteeth.com" }
    user.type "Volunteer"
  end

  factory :admin do |user|
    user.password_digest "legit password"
    user.name "Dr. Shark, MD, DDS, PhD"
    user.sequence(:email) { |n| "dr.shark#{ n }@weloveteeth.com" }
    user.type "Admin"
  end

  factory :student do |user|
    user.password_digest "legit password"
    user.name "Dr. Shark, MD, DDS, PhD"
    user.sequence(:email) { |n| "dr.shark#{ n }@weloveteeth.com" }
    user.type "Student"
  end
end
