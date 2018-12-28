# frozen_string_literal: true

class EmployeesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :no_employee

  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:success] = '従業員アカウントを作成しました。'
      redirect_to @employee
    else
      flash.now[:warning] = '正しく入力してください。'
      render 'new'
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.authenticate(params[:employee][:password]) && @employee.update(employee_params)
      flash[:success] = '従業員情報を更新しました。'
      redirect_to @employee
    else
      flash.now[:warning] = '正しく入力してください。'
      render 'edit'
    end
  end

  def destroy; end

  private

  def employee_params
    params.require(:employee).permit(:fullname, :username, :password, :password_confirmation)
  end

  def no_employee
    flash[:warning] = '該当従業員は存在しません。不正なリクエストです。'
    redirect_to employees_path
  end
end
