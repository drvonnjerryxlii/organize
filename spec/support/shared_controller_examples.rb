valid_authenticated_users = [:admin, :student, :volunteer]

# request outside example: -----------------------------------------------------

RSpec.shared_examples "a 200 response" do |template|
  it "reponds successfully with a 200 status code" do
    expect(response).to have_http_status(200)
    expect(response).to be_success
  end

  it "renders the #{ template } template" do
    expect(response).to render_template(template)
  end
end

RSpec.shared_examples "a 302 response" do |redirect_path|
  it "reponds successfully with a 302 status code" do
    expect(response).to have_http_status(302)
  end

  it "redirects to #{ redirect_path }" do
    expect(response).to redirect_to(redirect_path)
  end
end

RSpec.shared_examples "a redirect to the login page" do
  it_behaves_like "a 302 response", "/login"
end

RSpec.shared_examples "a redirect to the home page" do
  it_behaves_like "a 302 response", "/"
end

# request inside example: ------------------------------------------------------

RSpec.shared_examples "a 200 response for specified user type" do |template, factory, user_type|
  context "authenticated #{ user_type } users" do
    before :each do
      @user = create user_type
      valid_session = { user_id: @user.id }

      url_options = {}
      unless template == "index" || template == "new"
        instance = create factory
        url_options[:id] = instance.id
      end

      get template, url_options, valid_session
    end

    it_behaves_like "a 200 response", template
    it "assigns the #{ user_type } user to @logged_in_user" do
      expect(assigns(:logged_in_user).class).to eq @user.class
    end
  end
end

RSpec.shared_examples "a 302 response for specified user type" do |template, factory, user_type|
  context "authenticated #{ user_type } users" do
    before :each do
      user = create user_type
      valid_session = { user_id: user.id }

      url_options = {}
      unless template == "index" || template == "new"
        instance = create factory
        url_options[:id] = instance.id
      end

      get template, url_options, valid_session
    end

    it_behaves_like "a redirect to the home page"
  end
end

RSpec.shared_examples "a 200 response for *all* users" do |template, url_options|
  context "unauthenticated users" do
    before :each do
      session = nil
      get template, url_options
    end

    it_behaves_like "a 200 response", template
  end

  valid_authenticated_users.each do |user_type|
    it_behaves_like "a 200 response for specified user type", template, url_options, user_type
  end
end

RSpec.shared_examples "a 200 response only for authenticated users" do |template, url_options|
  context "unauthenticated users" do
    before :each do
      session = nil
      get template, url_options
    end

    it_behaves_like "a redirect to the home page"
  end

  context "authenticated users" do
    valid_authenticated_users.each do |user_type|
      it_behaves_like "a 200 response for specified user type", template, url_options, user_type
    end
  end
end

RSpec.shared_examples "a 200 response only for admin users" do |template, factory|
  before :each do
    @url_options = {}

    if factory
      instance = create factory
      @url_options[:id] = instance.id
    end
  end

  context "unauthenticated users" do
    before :each do
      session = nil
      get template, @url_options
    end

    it_behaves_like "a redirect to the home page"
  end

  context "authenticated users" do
    valid_authenticated_users.each do |user_type|
      response_code = (user_type == :admin) ? 200 : 302
      it_behaves_like "a #{ response_code } response for specified user type", template, factory, user_type
    end
  end
end
