require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe GuestLecture, type: :model do
  context "instantiation" do
    factory = :guest_lecture
    required_fields = [:user_id, :title]
    optional_fields = [:description]
    integer_fields = [:user_id]
    limited_fields = [{ title: 50 }, { description: 500 }]

    it_behaves_like "a model class with required fields", factory, required_fields
    it_behaves_like "a model class with optional fields", factory, optional_fields
    it_behaves_like "numeric integer fields", factory, integer_fields
    it_behaves_like "text fields w/ limits", factory, limited_fields
  end

  context "relationships" do
    it "belongs to a user"
  end
end
