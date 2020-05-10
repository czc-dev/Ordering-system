# frozen_string_literal: true

RSpec.describe 'Orders GET /patients/:patient_id/orders', type: :request, js: true do
  let(:patient) { create(:patient) }
  let(:order) { create_list(:order, 10, patient: patient) }
  let(:params) { { page: 1 } }

  include_context :act_login_as_employee

  before { get "/patients/#{patient.id}/orders" }

  it "can show patient's orders exclude canceled one on first page" do
    expect(assigns[:orders]).to eq(patient.orders_only_active.page(params[:page]))
  end

  it 'should use variable "page" for making ajax request' do
    expect(assigns[:page]).to eq(params[:page])
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
end
