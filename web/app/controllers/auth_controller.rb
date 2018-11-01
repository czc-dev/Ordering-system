# frozen_string_literal: true

class AuthController < ApplicationController
  def login; end

  def create
    employee = Employee.find_by(username: params[:username])
    # '&.' is 'safe navigation'
    if employee&.authenticate(params[:password])
      session[:current_employee_id] = employee.id
      flash[:success] = 'ログインしました。'
      redirect_to root_path
    else
      flash.now[:warning] = '正しく入力してください。'
      render 'login'
    end
  end

  def destroy
    if session[:current_employee_id]
      reset_session
      flash[:success] = 'ログアウトしました。'
      redirect_to root_path
    else
      flash[:warning] = 'ログインしてください。'
      redirect_to login_path
    end
  end
end
