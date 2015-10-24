require 'google/api_client'

require "#{ Rails.root }/lib/gcal_v3_wrapper/auth"
require "#{ Rails.root }/lib/gcal_v3_wrapper/event"
require "#{ Rails.root }/lib/gcal_v3_wrapper/calendar"

module GCalV3Wrapper
  def self.to_iso8601(time)
    # my people only believe in Time
    # raise TypeError, "Input is not a recognized time object. Please try again when you have Time." if time.class != Time

    return time.utc.iso8601
  end

  def self.require_params(required_params_array, actual_params)
    # my people only believe in Hash
    raise ArgumentError, "You must pass a params hash into this method." unless actual_params.class == Hash
    required_params_array.each do |req|
      raise ArgumentError, "Your params are missing a required key: #{ req }." unless actual_params[req]
    end
  end
end
