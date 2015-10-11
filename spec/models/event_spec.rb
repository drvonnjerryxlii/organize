require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Event, type: :model do
  context "instantiation" do
    factory = :event
    required_fields = [:title, :start_time, :end_time, :google_event_id]
    optional_fields = [:admin_only, :cohort_id]
    default_values = [{ admin_only: false }]

    it_behaves_like "a model class with required fields", factory, required_fields
    it_behaves_like "a model class with optional fields", factory, optional_fields
  end

  context "relationships" do
    it "has and belongs to many event attendees"
    it "has many users through its event attendees"
    it "has many guest lectures through its users"
  end
end
