require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe User, type: :model do
  describe "model validations" do
    subject { create(:user) } # this is required for the uniqueness spec

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(250) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:email).is_at_most(320) }

    it { should validate_presence_of(:type) }

    it { should have_secure_password }
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
