class InvitationsController < ApplicationController
  before_action :set_organization, only: %i[index new create]

  def index
    @invitations = @organization.invitations
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @organization.invitations.create!(invitation_params)
    flash[:success] = '招待リンクを作成しました。'
    redirect_to organization_invitations_url(@organization)
  end

  def destroy
    invitation = Invitation.find_by(id: params[:id])
    organization = invitation.organization
    invitation.revoke
    flash[:success] = '招待リンクを無効化しました。'
    redirect_to organization_invitations_url(organization)
  end

  private

  def set_organization
    @organization = Organization.find_by(id: params[:organization_id])
  end

  def invitation_params
    params.require(:invitation).permit(:expired_at)
  end
end
