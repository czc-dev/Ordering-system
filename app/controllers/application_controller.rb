class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :authenticate_employee

  private

  def authenticate_employee
    return if logged_in?
    flash[:warning] = 'ログインが必要です。'
    redirect_to login_path
  end
end
