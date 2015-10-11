require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe User, type: :model do
  factory = :user
  required_fields = [:name, :email, :type]
  optional_fields = [:password_digest]

  it_behaves_like "a model class with required fields", factory, required_fields
  it_behaves_like "a model class with optional fields", factory, optional_fields
end
