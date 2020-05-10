# frozen_string_literal: true

RSpec.describe 'Orders POST /patients/:patient_id/orders', type: :request, js: true do
  let(:patient) { create(:patient) }
  include_context :act_login_as_employee

  subject { post patient_orders_path(patient.id), params: params }

  context 'when the request is valid' do
    let(:params) do
      { order: { exam_item_ids: (1..10).to_a, may_result_at: Time.zone.now + 10.days } }
    end

    it 'creates a order' do
      expect { subject }.to change { patient.orders.count }.by(1)
    end

    it 'creates exams as you selected' do
      expect { subject }.to change { patient.orders.first&.exams&.count || 0 }.by(10)
    end

    it { is_expected.to redirect_to(order_exams_path(patient.orders.first)) }
  end

  context 'when no exams selected' do
    let(:params) do
      { order: { may_result_at: Time.zone.now + 10.days } }
    end

    it { is_expected.to render_template('new') }

    it 'returns status code 400(Bad request)' do
      subject
      expect(response).to have_http_status(400)
    end
  end
end
