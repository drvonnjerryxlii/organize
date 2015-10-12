require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe User, type: :model do
  factory = :user
  required_fields = [:name, :email, :type]
  optional_fields = [:password_digest]
  limited_fields = [{ name: 250 }, { email: 320 }]

  it_behaves_like "a model class with required fields", factory, required_fields
  it_behaves_like "a model class with optional fields", factory, optional_fields
  it_behaves_like "text fields w/ limits", factory, limited_fields
end
