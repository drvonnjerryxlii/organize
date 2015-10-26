require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe SpecialCondition, type: :model do
  describe "model validations" do
    it { should validate_presence_of(:calendar_id) }
    it { should validate_presence_of(:new_ta_requirement) }
    it { should validate_presence_of(:date) }

    # FIXME: shoulda-matchers 3.0.1
    # it { should validate_numericality_of(:calendar_id).only_integer }
    # it { should validate_numericality_of(:new_ta_requirement).only_integer }


    # factory = :special_condition
    # integer_fields = [:calendar_id, :new_ta_requirement]
    # it_behaves_like "numeric integer fields", factory, integer_fields
  end

  describe "model associations" do
    it { should belong_to(:calendar) }
  end
end
