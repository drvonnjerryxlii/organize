class Oauth < ActiveRecord::Base
  validates_presence_of :user_id, :provider, :provider_uid
end
