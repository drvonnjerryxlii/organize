FactoryGirl.define do
  factory :guest_lecture do
    user_id 1
    title "Shark Party 101"
    description "30-45min presentation about organizing a shark party & getting the best sharks to come tear fish apart."

    factory :guest_lecture_without_description do
      description nil
    end
  end
end
