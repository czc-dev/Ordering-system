# frozen_string_literal: true

class PatientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :no_patient
  def index
    @patients = Patient.all
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      flash[:success] = '患者を登録しました。'
      redirect_to @patient
    else
      flash.now[:warning] = '正しく入力してください。'
      render 'new'
    end
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(patient_params)
      flash[:success] = '患者情報を更新しました。'
      redirect_to @patient
    else
      flash.now[:warning] = '正しく入力してください。'
      render 'edit'
    end
  end

  def destroy; end

  private

  def patient_params
    params.require(:patient).permit(:age, :birth, :gender_id, :name)
  end

  def no_patient
    flash[:warning] = '該当患者は存在しません。不正なリクエストです。'
    redirect_to patients_path
  end
end
