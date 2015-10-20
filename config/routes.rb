require Rails.root.join('lib/build_constraints_regex')

Rails.application.routes.draw do

  # volunteering home page
  root "welcome#index"

  # authorization routes -------------------------------------------------------
  get "/login" => "sessions#login"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#logout"

  # authorized oauth providers
  # NOTE: if you change these, you'll need to update the routing specs in spec/routing/sessions_routing_spec
  authorized_providers = ["twitter", "github", "google_plus"]
  constraints_regex = build_contraints_regex(authorized_providers)
  PROVIDER_CONSTRAINTS = { provider: constraints_regex }

  get "/auth/:provider/callback", to: "sessions#oauth", constraints: PROVIDER_CONSTRAINTS

  # authenticated routes --------------------------------------------------
  # request shift? || request shift from hashed url # TODO: research hashed urls or whatevs they called
  # request


  scope "/:locale" do
    # categories w/ categorizables inside
    resources :categories do
      get "/broadcasts" => "categories#broadcasts"
      get "/lectures" => "categories#guest_lectures"
      get "/notes" => "categories#notes"
      get "/users" => "categories#users"
    end

    resources :broadcasts
    resources :cohorts
    resources :events
    resources :guest_lectures # FIXME: make this /lectures!
    resources :notes
    resources :users
    # resources :oauths
  end
end
