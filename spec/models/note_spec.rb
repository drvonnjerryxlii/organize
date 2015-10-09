require 'rails_helper'

RSpec.describe Note, type: :model do
  context "instantiation" do
    factory = :note
    required_fields = [:user_id, :note]

    it_behaves_like "a model class with required fields", factory, required_fields
  end

  context "relationships" do
    it "belongs to a user"
  end
end
