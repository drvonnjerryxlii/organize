require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe GuestLecture, type: :model do
  context "model validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(50) }
    it { should validate_length_of(:description).is_at_most(500) }

    # FIXME: shoulda-matchers 3.0.1
    # it { should validate_numericality_of(:user_id).only_integer }

    factory = :guest_lecture
    optional_fields = [:description]
    it_behaves_like "a model class with optional fields", factory, optional_fields

    integer_fields = [:user_id]
    it_behaves_like "numeric integer fields", factory, integer_fields
  end

  context "relationships" do
    it "belongs to a user"
  end
end
