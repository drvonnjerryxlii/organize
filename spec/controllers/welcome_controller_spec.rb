require 'rails_helper'
require 'support/shared_controller_examples'

RSpec.describe WelcomeController, type: :controller do
  describe "GET #index" do
    template = "index"
    url_options = {}

    it_behaves_like "a 200 response for *all* users", template
  end
end
