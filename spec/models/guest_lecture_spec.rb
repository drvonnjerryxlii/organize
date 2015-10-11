require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe GuestLecture, type: :model do
  context "instantiation" do
    factory = :guest_lecture
    required_fields = [:user_id, :title]
    optional_fields = [:description] # FIXME: this is currently a req'd field make migration

    it_behaves_like "a model class with required fields", factory, required_fields
    it_behaves_like "a model class with optional fields", factory, optional_fields
  end

  context "relationships" do
    it "belongs to a user"
  end
end
