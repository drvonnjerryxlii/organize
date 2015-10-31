class WelcomeController < ApplicationController
  skip_before_action :require_login
  skip_before_action :require_admin
  before_action :set_logged_in_user
  before_action :set_admin

  def index
    if @admin

      @calendars = prepare_calendars
      @categories = Category.pending

    elsif @logged_in_user && @logged_in_user.events

      @events = @logged_in_user.events.future

    end
  end

  private

    def prepare_calendars
      Calendar.all.select { |c| c.events.pending.count > 0 }
    end
end
