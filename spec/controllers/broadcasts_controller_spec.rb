require 'rails_helper'
require 'support/admin_controller_examples'

RSpec.describe BroadcastsController, type: :controller do
  # NOTE: we can't use a factory for this, because it's not possible to build or
  # create or really use factories outside of it or before blocks. ;_;
  # if valid_params is attributes_for :broadcast, we get the following error:
  # `method_missing': `valid_params` is not available on an example group (e.g.
  # a `describe` or `context` block). It is only available from within
  # individual examples (e.g. `it` blocks) or from constructs that run in the
  # scope of an example (e.g. `before`, `let`, etc).
  # (RSpec::Core::ExampleGroup::WrongScopeError)

  options = {
    factory: :broadcast,
    valid_params: { broadcast: {
      title: "what a great title",
      description: "all your base your base your base base, all your base are belong to us"
    } },
    update_params: { title: "even more super great title" },
    invalid_params: { broadcast: { description: nil, title: nil, name: "super great title" } }
  }

  it_behaves_like "admin-only resource controller", options
end
