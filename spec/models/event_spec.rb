require 'rails_helper'

RSpec.describe Event, type: :model do
  context "instantiation" do
    it "cannot be instantiated wihout a title"
    it "cannot be instantiated wihout a start time"
    it "cannot be instantiated wihout an end time"
    it "cannot be instantiated wihout a google_id"
  end

  context "relationships" do
    it "has and belongs to many event attendees"
    it "has many users through its event attendees"
    it "has many guest lectures through its users"
  end
end
