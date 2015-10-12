require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Note, type: :model do
  context "attributes" do
    factory = :note
    required_fields = [:user_id, :note]
    integer_fields = [:user_id]

    it_behaves_like "a model class with required fields", factory, required_fields
    it_behaves_like "numeric integer fields", factory, integer_fields
  end

  context "relationships" do
    it "belongs to a user"
  end
end
