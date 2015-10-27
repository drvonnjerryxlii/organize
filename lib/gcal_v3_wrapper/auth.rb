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

      # load private key
      key = OpenSSL::PKey::RSA.new ENV['GOOGLE_PRIVATE_KEY'], 'notasecret'

      # generate request body for authorization
      client.authorization = Signet::OAuth2::Client.new(
        :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
        :audience => 'https://accounts.google.com/o/oauth2/token',
        :scope => scope,
        :issuer => ENV['GOOGLE_ISSUER'],
        :signing_key => key
      )

      # fetch access token
      client.authorization.fetch_access_token!

      # return authorized client
      return client

      # sauce: http://blog.joshsoftware.com/2014/09/08/tutorial-using-google-service-accounts-with-rails-application/
    end

    def self.write
      get_authorized_client(WRITE_ACCESS_URI)
    end

    def self.readonly
      get_authorized_client(READONLY_ACCESS_URI)
    end
  end
end
