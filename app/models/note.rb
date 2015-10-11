class Note < ActiveRecord::Base
  validates_presence_of :user_id, :note
end
