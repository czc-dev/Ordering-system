class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :set_paper_trail_whodunnit
  before_action :require_login

  private

  def user_for_paper_trail
    current_employee.id
  end
end
