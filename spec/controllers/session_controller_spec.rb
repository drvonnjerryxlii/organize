require 'rails_helper'
require 'support/shared_controller_examples'

RSpec.describe SessionsController, type: :controller do
  describe "GET #login" do
    template = "login"
    url_options = {}

    it_behaves_like "a 200 response for *all* users", template
  end

  describe "POST #create" do
    context "valid form input" do
      before :each do
        email = "potato@potato.potato"
        password = "potatopassword"
        @user = create :user, email: email, password: password, password_confirmation: password
        @params = { email: email, password: password }
        post :create, session: @params
      end

      it "redirects to home page" do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end

      it "creates a new session" do # OPTIMIZE: this creates new user test
        expect(session[:user_id]).to eq(@user.id)
      end
    end

    context "invalid form input" do
      before :each do
        email = "potato@nope.potato"
        password = "potatopassword"
        @user = create :user, email: email, password: password, password_confirmation: password
        @params = { email: nil, password: password }
        post :create, session: @params
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders login template" do
        expect(response).to render_template("login")
      end
    end
  end

  describe "DELETE #logout" do
    before :each do
      @user = create :user
      session[:user_id] = @user.id
      delete :logout
    end

    it "resets the value of session[:user_id] to nil" do
      expect(session[:user_id]).to eq(nil)
    end

    it "redirects the user to the home page" do
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end
  end
end
