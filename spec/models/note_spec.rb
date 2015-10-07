require 'rails_helper'

RSpec.describe Note, type: :model do
  context "instantiation" do
    it "cannot be instantiated wihout a user_id"
    it "cannot be instantiated wihout a note"
  end

  context "relationships" do
    it "belongs to a user"
  end
end
