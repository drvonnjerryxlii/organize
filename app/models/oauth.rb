class Oauth < ActiveRecord::Base
  validates_presence_of :user_id, :provider, :provider_uid
  validates :user_id, numericality: { only_integer: true }
  validates :provider, length: { maximum: 64 }
end
