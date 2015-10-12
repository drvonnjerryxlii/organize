FactoryGirl.define do
  factory :category do |cat|
    cat.sequence(:name) { |n| "sharktastic #{ n }" }
  end
end
