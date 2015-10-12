class Note < ActiveRecord::Base
  validates_presence_of :user_id, :note
  validates :user_id, numericality: { only_integer: true }
end
