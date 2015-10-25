require 'rails_helper'
require 'support/shared_model_examples'

RSpec.describe Calendar, type: :model do
  describe "model validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:google_calendar_id) }
  end

  describe "model associations" do
    it { should have_and_belong_to_many(:users) }
    it { should have_many(:events) }
  end
end
