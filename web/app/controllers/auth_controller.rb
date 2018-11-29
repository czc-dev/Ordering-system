# frozen_string_literal: true

class AuthController < ApplicationController
  skip_before_action :authenticate_employee

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
    else
      flash[:warning] = 'ログインしてください。'
    end
    redirect_to login_url
  end

  def notify
    message = {
      title: params[:title],
      body: params[:body]
    }
    Webpush.payload_send(
      message: JSON.generate(message),
      endpoint: params[:subscription][:endpoint],
      p256dh: params[:subscription][:keys][:p256dh],
      auth: params[:subscription][:keys][:auth],
      vapid: {
        subject: "mailto:blue20will@gmail.com",
        public_key: ENV['VAPID_PUBLIC_KEY'],
        private_key: ENV['VAPID_PRIVATE_KEY']
      },
      ssl_timeout: 5, # value for Net::HTTP#ssl_timeout=, optional
      open_timeout: 5, # value for Net::HTTP#open_timeout=, optional
      read_timeout: 5 # value for Net::HTTP#read_timeout=, optional
    )
  end
end
