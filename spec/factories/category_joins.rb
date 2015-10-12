FactoryGirl.define do
  factory :category_join do
    category_id 1
    categorizable_type "Broadcast"
    categorizable_id 1

    factory :categorized_broadcast do
      categorizable_type "Broadcast"
    end

    factory :categorized_user do
      categorizable_type "User"
    end

    factory :categorized_guest_lecture do
      categorizable_type "GuestLecture"
    end

    factory :categorized_note do
      categorizable_type "Note"
    end
  end
end
