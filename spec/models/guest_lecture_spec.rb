require 'rails_helper'

RSpec.describe GuestLecture, type: :model do
  context "instantiation" do
    it "cannot be instantiated wihout a user_id"
    it "cannot be instantiated wihout a title"
    it "can be instantiated wihout a short_description"
  end

  context "relationships" do
    it "belongs to a user"
  end
end
