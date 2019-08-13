# frozen_string_literal: true

class AuthController < ApplicationController
  skip_before_action :authenticate_employee

  def new; end

  def create
    employee = Employee.find_by(username: params[:username])
    if employee&.authenticate(params[:password])
      session[:current_employee_id] = employee.id
      flash[:success] = 'ログインしました。'
      redirect_to root_path
    else
      flash.now[:warning] = '正しく入力してください。'
      render 'new'
    end
  end

  def destroy
    if session[:current_employee_id]
      reset_session
      flash[:success] = 'ログアウトしました。'
    else
      flash[:warning] = 'ログインしてください。'
    end
    redirect_to login_url
  end
end
