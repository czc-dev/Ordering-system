# frozen_string_literal: true

RSpec.describe 'Exams GET /orders/:order_id/exams', type: :request, js: true do
  let(:order) { create(:order) }
  let(:params) { { page: 1 } }

  include_context :act_login_as_employee

  subject { get order_exams_path(order.id) }

  it "can show order's exams exclude canceled one on first page" do
    subject
    expect(assigns[:exams]).to eq(order.exams_only_active.page(params[:page]))
  end

  it 'should use variable "page" for making ajax request' do
    subject
    expect(assigns[:page]).to eq(params[:page])
  end

  it 'returns status code 200' do
    subject
    expect(response).to have_http_status(200)
  end
end
