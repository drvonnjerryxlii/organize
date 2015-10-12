require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe GuestLecture, type: :model do
  describe "model validations" do
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

  describe "model associations" do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:categories).through(:categorizable).source(:category_joins) }
  end
end
