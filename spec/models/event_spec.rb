require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Event, type: :model do
  describe "model validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:google_event_id) }
    it { should validate_length_of(:google_event_id).is_at_most(1024) }

    # FIXME: shoulda-matchers 3.0.1
    # it { should validate_numericality_of(:cohort_id).only_integer }

    factory = :event
    optional_fields = [:admin_only, :cohort_id]
    it_behaves_like "a model class with optional fields", factory, optional_fields

    default_fields = [{ admin_only: false }]
    it_behaves_like "fields w/ default values", factory, default_fields

    integer_fields = [:cohort_id]
    it_behaves_like "numeric integer fields", factory, integer_fields

    # datetime_fields = [:start_time, :end_time] # FIXME: datetime testing?
  end

  describe "model associations" do
    it { should belong_to(:cohort) }
    it { should belong_to(:guest_lecture) }
    it { should have_many(:event_attendees) }
  end
end
