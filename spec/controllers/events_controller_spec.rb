require 'rails_helper'
require 'support/admin_controller_examples'

RSpec.describe EventsController, type: :controller do
  # NOTE: we can't use a factory for this, because it's not possible to build or
  # create or really use factories outside of it or before blocks. ;_;
  # if valid_params is attributes_for :broadcast, we get the following error:
  # `method_missing': `valid_params` is not available on an example group (e.g.
  # a `describe` or `context` block). It is only available from within
  # individual examples (e.g. `it` blocks) or from constructs that run in the
  # scope of an example (e.g. `before`, `let`, etc).
  # (RSpec::Core::ExampleGroup::WrongScopeError)

  options = {
    factory: :event,
    valid_params: { event: {
      title: 1,
      start_time: Time.parse("Oct 15 2015 11am"),
      end_time: Time.parse("Oct 15 2015 5pm"),
      google_event_id: "super legit id",
      admin_only: true,
      cohort_id: 1,
      guest_lecture_id: 1
    } },
    update_params: { title: "even more super great event" },
    invalid_params: { event: { user_id: "not a number", event: nil, name: "super great event" } }
  }

  it_behaves_like "admin-only resource controller", options
end
