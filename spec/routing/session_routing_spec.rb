require "rails_helper"

RSpec.describe SessionsController, type: :routing do
  describe "routing" do
    it "routes to #login" do
      expect(get: "/login").to route_to("sessions#login")
    end

    it "routes to #create via POST" do
      expect(post: "/login").to route_to("sessions#create")
    end

    it "routes to #logout via DELETE" do
      expect(delete: "/logout").to route_to("sessions#logout")
    end

    context "routes to #oauth" do
      supported_providers = ["github", "twitter", "google_plus"]
      supported_providers.each do |provider|
        it "provider = #{ provider }" do
          expect(get: "/auth/#{ provider }/callback").to route_to("sessions#oauth", provider: provider)
        end
      end

      not_supported_provider = "mr_potato_head"
      it "provider = #{ not_supported_provider }" do
        { get: "/auth/#{ not_supported_provider }/callback" }.should_not be_routable #FIXME: this raises a deprecation warning

        # expect{get: "/auth/#{ not_supported_provider }/callback"}.to raise_exception(ActionController::RoutingError)
        # NOPE: syntax error, unexpected ':', expecting '}' (SyntaxError)
        # expect{get: "/auth/#{ not_supported_prov...
      end
    end
  end
end
