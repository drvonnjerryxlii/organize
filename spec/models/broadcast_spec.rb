require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Broadcast, type: :model do
  # OPTIMIZE: find out why this doesn't work with `let`. see error next line.
  # `method_missing': `factory` is not available on an example group (e.g. a
  # `describe` or `context` block). It is only available from within individual
  # examples (e.g. `it` blocks) or from constructs that run in the scope of an
  # example (e.g. `before`, `let`, etc).
  # (RSpec::Core::ExampleGroup::WrongScopeError)
  factory = :broadcast
  required_fields = [:title, :short_description]

  it_behaves_like "a model class with required fields", factory, required_fields

  context "relationships" do
    it "has and belongs to zero to many categories"
  end
end
