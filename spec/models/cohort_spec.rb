require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Cohort, type: :model do
  describe "model validation" do
    # these are also datetime_fields # FIXME: validate datetime?
    it { should validate_presence_of(:classroom_start_date) }
    it { should validate_presence_of(:classroom_end_date) }
    it { should validate_presence_of(:internship_start_date) }
    it { should validate_presence_of(:internship_end_date) }

    factory = :cohort
    optional_fields = [:google_calendar_id]
    it_behaves_like "a model class with optional fields", factory, optional_fields
  end

  describe "model associations" do
    it { should have_many(:users) }
    it { should have_many(:events) }
  end
end
