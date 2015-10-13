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

  # TODO: should it have many notes & gl thru users as well; namespace association? user_notes?
  describe "model associations" do
    it { should have_many(:category_joins) }
    it { should have_many(:broadcasts).through(:category_joins).source(:categorizable) }
    it { should have_many(:users).through(:category_joins).source(:categorizable) }
    it { should have_many(:notes).through(:category_joins).source(:categorizable) }
    it { should have_many(:guest_lectures).through(:category_joins).source(:categorizable) }
  end
end
