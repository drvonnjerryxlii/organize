class User < ActiveRecord::Base
  validates_presence_of :name, :email, :type
  validates :name, length: { maximum: 250 }
  validates :email, length: { maximum: 320 }
end
