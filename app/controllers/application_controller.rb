class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :set_paper_trail_whodunnit
  before_action :authenticate_employee

  private

  def user_for_paper_trail
    current_employee.id
  end

  def authenticate_employee
    return if logged_in?

    flash[:warning] = 'ログインが必要です。'
    redirect_to login_path
  end
end
