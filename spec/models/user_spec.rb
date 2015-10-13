require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe User, type: :model do
  describe "model validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(250) }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_most(320) }
    it { should validate_presence_of(:type) }

    factory = :user
    # OPTIMIZE: find out why this doesn't work with `let`. see error next line.
    # `method_missing': `factory` is not available on an example group (e.g. a
    # `describe` or `context` block). It is only available from within individual
    # examples (e.g. `it` blocks) or from constructs that run in the scope of an
    # example (e.g. `before`, `let`, etc).
    # (RSpec::Core::ExampleGroup::WrongScopeError)
    optional_fields = [:password_digest]
    it_behaves_like "a model class with optional fields", factory, optional_fields
  end

  describe "model associations" do
    it { should have_many(:oauths) }
    it { should have_many(:guest_lectures) }
    it { should have_many(:notes) }
    it { should have_and_belong_to_many(:cohorts) }
    it { should have_and_belong_to_many(:events) }
    it { should have_many(:category_joins) } # FIXME: is this right?
    it { should have_many(:categories).through(:category_joins) }
    it { should have_many(:broadcasts).through(:categories) }
  end
end
