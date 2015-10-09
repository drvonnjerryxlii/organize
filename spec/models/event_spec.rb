require 'rails_helper'

RSpec.describe Event, type: :model do
  context "instantiation" do
    factory = :event
    required_fields = [:title, :start_time, :end_time, :google_id]

    it_behaves_like "a model class with required fields", factory, required_fields
  end

  context "relationships" do
    it "has and belongs to many event attendees"
    it "has many users through its event attendees"
    it "has many guest lectures through its users"
  end
end
