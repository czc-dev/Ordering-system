class OrganizationsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :verify_token, only: %i[new create]

  def show
  end

  def new; end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      flash[:success] = 'ワークスペース（組織）を作成しました。'
      @invitation.renew_for_newly_created_organization!(@organization)
      redirect_to new_organization_employee_path(@organization, params: { invitation_token: @invitation.token })
    else
      flash.now[:warning] = 'ワークスペース名（組織名）は必ず入力してください。'
      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def organization_params
    params.require(:organization).permit(:name)
  end

  def verify_token
    @invitation = Invitation.find_by(token: params[:invitation_token])
    return if @invitation&.email.present?

    redirect_to '/create', warning: '該当リンクが正しくないか期限切れです。'
  end
end
