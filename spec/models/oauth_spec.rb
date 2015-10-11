require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Oauth, type: :model do
  context "instantiation" do
    factory = :oauth
    required_fields = [:user_id, :provider, :provider_uid]

    it_behaves_like "a model class with required fields", factory, required_fields
  end

  context "relationships" do
    it "belongs to a user"
  end
end
