Rails.application.routes.draw do
  # volunteering home page
  root "welcome#index"

  # calendars
  get "/calendar" => "calendars#public", as: "public_calendar"
  get "/calendar/a" => "calendars#admin", as: "admin_calendar"
  get "/calendar/v" => "calendars#volunteer", as: "volunteer_calendar"
  # does it make more sense to nest these like /admin/calendar instead?
  # or have the logic in the controller decide which view? I like this better

  # login
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  # admin space
  resources :admin # admin can add new admin but can only edit self
  resources :faqs
  resources :events
  resources :broadcasts
  resources :categories
  resources :volunteers, only: [:index, :show, :new, :create, :destroy] do
    resources :notes # notes are attached to specific volunteers
  end

  # volunteer space
  resources :volunteers, only: [:show, :edit, :update]

  # all public faq
  # specific public faq

  # all faq (pub & priv)
  # specific faq (pub or priv)
end
