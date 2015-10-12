require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Oauth, type: :model do
  context "attributes" do
    factory = :oauth
    required_fields = [:user_id, :provider, :provider_uid]
    integer_fields = [:user_id]
    limited_fields = [{ provider: 64 }]

    it_behaves_like "a model class with required fields", factory, required_fields
    it_behaves_like "numeric integer fields", factory, integer_fields
    it_behaves_like "text fields w/ limits", factory, limited_fields
  end

  context "relationships" do
    it "belongs to a user"
  end
end
