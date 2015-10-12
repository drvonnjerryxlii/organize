class GuestLecture < ActiveRecord::Base
  validates_presence_of :user_id, :title
  validates :user_id, numericality: { only_integer: true }
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 500 }, allow_blank: true
end
