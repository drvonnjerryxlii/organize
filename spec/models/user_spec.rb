require 'rails_helper'

RSpec.describe User, type: :model do
  factory = :user
  required_fields = [:password_digest, :name, :email, :type]

  it_behaves_like "a model class with required fields", factory, required_fields
end
