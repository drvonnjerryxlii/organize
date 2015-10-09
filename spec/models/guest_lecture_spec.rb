require 'rails_helper'

RSpec.describe GuestLecture, type: :model do
  context "instantiation" do
    factory = :guest_lecture
    required_fields = [:user_id, :title]
    optional_fields = [:short_description]

    it_behaves_like "a model class with required fields", factory, required_fields
    it_behaves_like "a model class with optional fields", factory, optional_fields
  end

  context "relationships" do
    it "belongs to a user"
  end
end
