require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe CategoryJoin, type: :model do
  describe "model validations" do
    it { should validate_presence_of(:category_id) }
    it { should validate_presence_of(:categorizable_id) }
    it { should validate_presence_of(:categorizable_type) }
    # FIXME: shoulda-matchers 3.0.1
    # it { should validate_numericality_of(:category_id).only_integer }
    # it { should validate_numericality_of(:categorizable_id).only_integer }

    factory = :category_join
    integer_fields = [:category_id, :categorizable_id]
    it_behaves_like "numeric integer fields", factory, integer_fields

    context "categorizable_type" do
      it "accepts only valid types" # TODO: finish this & pull into shared movel examples
        valid_types = ["Broadcast", "GuestLecture", "Note", "User"]
        invalid_types = ["Potato", "Shark", "Amanita", "Notebook"]
    end
  end

  describe "model associations" do
    it { should belong_to(:category) }
    it { should belong_to(:categorizable) }
  end
end
