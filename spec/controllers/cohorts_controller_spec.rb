require 'rails_helper'
require 'support/admin_controller_examples'

RSpec.describe CohortsController, type: :controller do
  # NOTE: we can't use a factory for this, because it's not possible to build or
  # create or really use factories outside of it or before blocks. ;_;
  # if valid_params is attributes_for :broadcast, we get the following error:
  # `method_missing': `valid_params` is not available on an example group (e.g.
  # a `describe` or `context` block). It is only available from within
  # individual examples (e.g. `it` blocks) or from constructs that run in the
  # scope of an example (e.g. `before`, `let`, etc).
  # (RSpec::Core::ExampleGroup::WrongScopeError)

  options = {
    factory: :cohort,
    valid_params: { cohort: {
      classroom_start_date: Time.parse("May 4 2015"),
      classroom_end_date: Time.parse("Nov 23 2015"),
      internship_start_date: Time.parse("Nov 30 2015"),
      internship_end_date: Time.parse("Apr 29 2016"),
      google_calendar_id: "totally legit calendar id"
    } },
    update_params: { google_calendar_id: "even more super legit id" },
    invalid_params: { cohort: {
      internship_end_date: nil,
      google_calendar_id: nil,
      name: "super legit id"
    } }
  }

  it_behaves_like "admin-only resource controller", options
end
