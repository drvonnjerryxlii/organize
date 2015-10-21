class WelcomeController < ApplicationController
  skip_before_action :require_login
  skip_before_action :require_admin
  before_action :set_logged_in_user
  before_action :set_admin

  def root; end
end
