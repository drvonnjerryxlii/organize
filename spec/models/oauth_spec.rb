require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Oauth, type: :model do
  context "attributes" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:provider) }
    it { should validate_length_of(:provider).is_at_most(64) }
    it { should validate_presence_of(:provider_uid) }

    # FIXME: shoulda-matchers 3.0.1
    # it { should validate_numericality_of(:user_id).only_integer }

    factory = :oauth
    integer_fields = [:user_id]
    it_behaves_like "numeric integer fields", factory, integer_fields
  end

  context "relationships" do
    it "belongs to a user"
  end
end
