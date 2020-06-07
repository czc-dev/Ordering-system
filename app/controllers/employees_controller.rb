# frozen_string_literal: true

class EmployeesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :no_employee
  skip_before_action :require_login, only: %i[new create]
  before_action :set_organization, only: %i[index new create]
  before_action :verify_token, only: %i[new create]

  def index
    @employees = Employee.accessible_by(current_ability).page(params[:page])
  end

  def show
    @employee = Employee.accessible_by(current_ability).find(params[:id])
  end

  def new
    @employee = @organization.employees.new
  end

  def create
    @employee = @organization.employees.new(create_params)
    if @employee.save
      @invitation.revoke
      login(create_params[:email], create_params[:password])
      flash[:success] = '従業員アカウントを作成しました。'
      redirect_to @employee
    else
      flash.now[:warning] = '正しく入力してください。'
      render :new, status: :bad_request
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.valid_password?(params[:employee][:password]) && @employee.update(update_params)
      flash[:success] = '従業員情報を更新しました。'
      redirect_to @employee
    else
      flash.now[:warning] = '正しく入力してください。'
      render :edit, status: :bad_request
    end
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.discard
    logout
    redirect_to login_url
  end

  private

  def create_params
    params.require(:employee).permit(:fullname, :email, :password, :password_confirmation)
  end

  def update_params
    params.require(:employee).permit(:fullname, :email)
  end

  def set_organization
    @organization = Organization.find_by(id: params[:organization_id])
  end

  def verify_token
    @invitation = Invitation.find_by(token: params[:invitation_token])
    return if @invitation&.organization.present? && @invitation.active?

    flash[:warning] = '該当リンクが正しくないか期限切れです。'
    redirect_to '/create'
  end

  def no_employee
    flash[:warning] = '該当従業員は存在しません。不正なリクエストです。'
    redirect_to organization_employees_path(current_user.organization)
  end
end
