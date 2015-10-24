FactoryGirl.define do
  factory :broadcast do
    title "Shark Attack"
    description "We need volunteers to help set up before & clean up after the shark attack party"
    active false

    factory :broadcast_without_active do
      active nil
    end
  end
end
