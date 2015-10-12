require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe CategoryJoin, type: :model do
  context "instantiation" do
    factory = :category_join
    required_fields = [:category_id, :categorizable_id, :categorizable_type]
    integer_fields = [:category_id, :categorizable_id]

    it_behaves_like "a model class with required fields", factory, required_fields
    it_behaves_like "numeric integer fields", factory, integer_fields
  end

  it "has relationships" # FIXME: flesh out category_join relationships
end
