require 'rails_helper'
require 'support/admin_controller_examples'

RSpec.describe UsersController, type: :controller do
  # NOTE: we can't use a factory for this, because it's not possible to build or
  # create or really use factories outside of it or before blocks. ;_;
  # if valid_params is attributes_for :broadcast, we get the following error:
  # `method_missing': `valid_params` is not available on an example group (e.g.
  # a `describe` or `context` block). It is only available from within
  # individual examples (e.g. `it` blocks) or from constructs that run in the
  # scope of an example (e.g. `before`, `let`, etc).
  # (RSpec::Core::ExampleGroup::WrongScopeError)

  options = {
    factory: :user,
    valid_params: { user: {
      password_digest: "legit password",
      name: "Dr. Shark, MD, DDS, PhD",
      email: "dr.shark#{ Time.now.to_i }#{ rand(100) }@weloveteeth.com",
      type: "Volunteer"
    } },
    update_params: { name: "even more super great name" },
    invalid_params: { user: { name: nil, type: nil, thunderbolt: "best pokemanz" } },
    except: [:show, :edit, :update]
  }

  it_behaves_like "admin-only resource controller", options
end
