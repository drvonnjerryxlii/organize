require 'rails_helper'

RSpec.describe Category, type: :model do
  context "instantiation" do
    it "cannot be instantiated wihout a name"
    it "has a default color value"
    it "has a default admin_only value"
  end

  context "relationships" do
    it "has and belongs to many broadcasts"
    it "has and belongs to many users"
    it "has many notes through its users"
    it "has many guest lectures through its users"
  end
end
