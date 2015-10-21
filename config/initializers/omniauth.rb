Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    :fields => [:first_name, :last_name],
    :uid_field => :last_name
  # provider :instagram, ENV["INSTAGRAM_CLIENT_ID"], ENV["INSTAGRAM_CLIENT_SECRET"]
  # provider :vimeo, ENV["VIMEO_CLIENT_ID"], ENV["VIMEO_CLIENT_SECRET"]
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']
  # provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]
end
