class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :set_paper_trail_whodunnit
  before_action :require_login

  private

  def not_authenticated
    flash[:warning] = 'ログインが必要です。'
    redirect_to login_path
  end

  def user_for_paper_trail
    current_user&.id
  end
end
