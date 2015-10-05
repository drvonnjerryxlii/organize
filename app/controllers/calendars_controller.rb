class CalendarsController < ApplicationController
  protect_from_forgery with: :exception

  def public; end
  def admin; end
  def volunteer; end
end
