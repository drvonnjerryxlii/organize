require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Note, type: :model do
  context "attributes" do
    it { should validate_presence_of(:note) }
    it { should validate_presence_of(:user_id) }

    # FIXME: shoulda-matchers 3.0.1
    # it { should validate_numericality_of(:user_id).only_integer }

    factory = :note
    integer_fields = [:user_id]
    it_behaves_like "numeric integer fields", factory, integer_fields
  end

  context "relationships" do
    it "belongs to a user"
  end
end
