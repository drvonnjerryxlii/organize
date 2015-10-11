require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Cohort, type: :model do
  context "instantiation" do
    factory = :cohort
    required_fields = [
      :classroom_start_date,
      :classroom_end_date,
      :internship_start_date,
      :internship_end_date
    ]
    optional_fields = [:google_calendar_id]

    it_behaves_like "a model class with required fields", factory, required_fields
    it_behaves_like "a model class with optional fields", factory, optional_fields
  end

  context "relationships" do
    it "needs fixing" # FIXME: cohort relationships
  end
end
