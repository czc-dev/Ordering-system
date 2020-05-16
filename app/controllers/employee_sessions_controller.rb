# frozen_string_literal: true

class EmployeeSessionsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    employee = login(params[:email], params[:password])

    if employee
      redirect_back_or_to(root_url, success: 'ログインしました。')
    else
      flash.now[:warning] = '正しく入力してください。'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to(login_url, success: 'ログアウトしました。')
  end
end
