class Broadcast < ActiveRecord::Base
  validates_presence_of :title, :description
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 500 }, allow_blank: true
end
