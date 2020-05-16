class InitOrganizationsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    if params[:email].present? && params[:email].match?(Employee::EMAIL_REGEX)
      Invitation.create!(email: params[:email])
      # send_mail_new_organization
      flash.now[:success] = 'メールを送信します。確認してください。'
      render :new, status: :ok
    else
      flash.now[:warning] = 'メールアドレスを正しく入力してください。'
      render :new, status: :bad_request
    end
  end
end
