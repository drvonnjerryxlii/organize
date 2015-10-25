require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Category, type: :model do
  describe "model validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of(:user_related) }
    it { should validate_presence_of(:topic_related) }
    # NOTE: these next three have defaults so this mightn't work
    it { should validate_presence_of(:admin_only) }
    it { should validate_presence_of(:approved) }
    it { should validate_presence_of(:hidden) }


    factory = :category

    optional_fields = [:color, :admin_only, :approved]
    it_behaves_like "a model class with optional fields", factory, optional_fields

    default_fields = [
      { admin_only: true },
      { approved: false }
    ]
    it_behaves_like "fields w/ default values", factory, default_fields
  end

  describe "model associations" do
    it { should have_many(:category_joins) }
    it { should have_many(:broadcasts).through(:category_joins).source(:categorizable) }
    it { should have_many(:users).through(:category_joins).source(:categorizable) }
    it { should have_many(:notes).through(:category_joins).source(:categorizable) }
    it { should have_many(:lectures).through(:category_joins).source(:categorizable) }
  end

  describe "scopes" do
    it "#alphabetized"
    it "#visible"
    it "#admin"
    it "#tags"
    it "#topics"
    it "#any_user"
    it "#any_user_tags"
    it "#any_user_topics"
  end
end
