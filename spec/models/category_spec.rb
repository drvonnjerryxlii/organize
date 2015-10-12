require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Category, type: :model do
  describe "model validations" do
    it { should validate_presence_of(:name) }

    factory = :category

    optional_fields = [:color, :admin_only, :approved]
    it_behaves_like "a model class with optional fields", factory, optional_fields

    default_fields = [
      { color: "white" },
      { admin_only: true },
      { approved: false }
    ]
    it_behaves_like "fields w/ default values", factory, default_fields
  end

  describe "model associations" do
    it { should have_and_belong_to_many(:broadcasts).through(:categorizable).source(:category_joins) }
    it { should have_and_belong_to_many(:users).through(:categorizable).source(:category_joins) }
    it { should have_many(:notes).through(:categorizable).source(:category_joins) }
    # FIXME: it should have many notes thru users as well; namespace association? user_notes?
    it { should have_many(:guest_lectures).through(:users) }
  end
end
