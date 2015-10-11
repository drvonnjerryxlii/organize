class GuestLecture < ActiveRecord::Base
  validates_presence_of :user_id, :title
end
