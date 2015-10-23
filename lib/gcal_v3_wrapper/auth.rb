module GCalV3Wrapper
  class Auth
    WRITE_ACCESS_URI = 'https://www.googleapis.com/auth/calendar'
    READONLY_ACCESS_URI = WRITE_ACCESS_URI + '.readonly'

    def self.get_authorized_client(scope)
      # initialize the client
      client = Google::APIClient.new(
        application_name: 'Ada Volunteer Portal Development',
        application_version: '0.0.1'
      )

      # load and decrypt private key
      key = Google::APIClient::KeyUtils.load_from_pkcs12(
        "#{ Rails.root }/goggle583e06af4ecd.p12", # best file name ever
        'notasecret'
      )

      # generate request body for authorization
      client.authorization = Signet::OAuth2::Client.new(
        :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
        :audience => 'https://accounts.google.com/o/oauth2/token',
        :scope => scope,
        :issuer => '421497866518-n75n2prhpt1al91bvpuln2og5jq31oa1@developer.gserviceaccount.com',
        :signing_key => key
      )

      # fetch access token
      client.authorization.fetch_access_token!

      # return authorized client
      return client

      # sauce: http://blog.joshsoftware.com/2014/09/08/tutorial-using-google-service-accounts-with-rails-application/
    end

    def self.write
      return self.get_authorized_client(WRITE_ACCESS_URI)
    end

    def self.readonly
      return self.get_authorized_client(READONLY_ACCESS_URI)
    end
  end
end
