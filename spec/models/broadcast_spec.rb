require 'rails_helper'

RSpec.describe Broadcast, type: :model do
  context "instantiation" do
    it "cannot be instantiated wihout a title"
    it "cannot be instantiated wihout a description"
  end

  context "relationships" do
    it "has and belongs to zero to many categories"
  end
end
