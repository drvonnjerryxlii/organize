require 'rails_helper'
require 'support/any_auth_user_controller_examples'
require 'support/admin_controller_examples'

RSpec.describe GuestLecturesController, type: :controller do
  # NOTE: we can't use a factory for this, because it's not possible to build or
  # create or really use factories outside of it or before blocks. ;_;
  # if valid_params is attributes_for :broadcast, we get the following error:
  # `method_missing': `valid_params` is not available on an example group (e.g.
  # a `describe` or `context` block). It is only available from within
  # individual examples (e.g. `it` blocks) or from constructs that run in the
  # scope of an example (e.g. `before`, `let`, etc).
  # (RSpec::Core::ExampleGroup::WrongScopeError)
  
  base_options = {
    factory: :guest_lecture,
    valid_params: { guest_lecture: {
      user_id: 1,
      title: "super legit lecture",
      description: "lecture about such super legit things as being legit and legitimacy"
    } },
    update_params: { title: "even more super great lecture" },
    invalid_params: { guest_lecture: { user_id: "not a number", title: nil, name: "super great lecture" } }
  }

  any_auth_options = base_options.deep_dup
  any_auth_options[:except] = [:show, :edit, :update, :destroy]

  it_behaves_like "any auth user resource controller", any_auth_options

  admin_options = base_options.deep_dup
  admin_options[:only] = [:show, :edit, :update, :destroy]

  it_behaves_like "admin-only resource controller", admin_options
end
