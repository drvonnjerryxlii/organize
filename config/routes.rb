require Rails.root.join('lib/build_constraints_regex')

Rails.application.routes.draw do
  # portal home
  root "welcome#index"

  # authorized oauth providers
  authorized_providers = ["github", "google_oauth2"]
  PROVIDER_CONSTRAINTS = { provider: build_contraints_regex(authorized_providers) }

  get "/auth/:provider/callback", to: "users#new_or_edit_oauth", constraints: PROVIDER_CONSTRAINTS

  # google calendar integration
  # get "/calendar/auth/google_oauth2/callback" => "calendars#create"

  scope "/:locale" do
    # authorization routes
    get "/login" => "sessions#login"
    post "/login" => "sessions#create"
    delete "/logout" => "sessions#logout"

    # normal resources
    resources :broadcasts
    # resources :events
    resources :guest_lectures, :path => "lectures"
    resources :notes
    resources :users

    # calendars w/ events inside
    resources :calendars do
      resources :events
    end

    # categories w/ categorizables inside
    resources :categories do
      get "/broadcasts" => "categories#broadcasts"
      get "/lectures" => "categories#guest_lectures"
      get "/notes" => "categories#notes"
      get "/users" => "categories#users"
    end
  end
end
