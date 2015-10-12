require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Broadcast, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(50) }
  it { should validate_presence_of(:description) }
  it { should validate_length_of(:description).is_at_most(500) }

  context "relationships" do
    it "has and belongs to zero to many categories"
  end
end
