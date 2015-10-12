require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Category, type: :model do
  context "instantiation" do
    factory = :category
    required_fields = [:name]
    optional_fields = [:color, :admin_only, :approved]
    default_fields = [
      { color: "white" },
      { admin_only: true },
      { approved: false }
    ]

    it_behaves_like "a model class with required fields", factory, required_fields
    it_behaves_like "a model class with optional fields", factory, optional_fields
    it_behaves_like "fields w/ default values", factory, default_fields

    it "has a default color value"
    it "has a default admin_only value"
    it "has a default approved value"
  end

  context "relationships" do
    it "has and belongs to many broadcasts"
    it "has and belongs to many users"
    it "has many notes through its users"
    it "has many guest lectures through its users"
  end
end
