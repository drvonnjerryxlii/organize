require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Broadcast, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(50) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_most(500) }
    it { should validate_presence_of(:active) }
  end

  describe "associations" do
    it { should have_many(:category_joins) } # QUESTION: is this right?
    it { should have_many(:categories).through(:category_joins) }
  end

  describe "scopes" do
    context "#active" do
      it "grabs the active broadcasts"
    end
  end
end
