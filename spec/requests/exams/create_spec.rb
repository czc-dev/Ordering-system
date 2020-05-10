# frozen_string_literal: true

RSpec.describe 'Exams POST /orders/:order_id/exams', type: :request, js: true do
  let(:order) { create(:order) }

  include_context :act_login_as_employee

  subject { post order_exams_path(order.id), params: params }

  context 'when the request is valid' do
    let(:params) do
      { order: { exam_item_ids: (1..10).to_a } }
    end

    it 'adds exams to order as you selected' do
      expect { subject }.to change { order.exams.count }.by(10)
    end

    it { is_expected.to redirect_to(order_exams_path(order.id)) }
  end

  context 'when no exams selected' do
    let(:params) do
      { order: { empty: '' } }
    end

    it { is_expected.to render_template('new') }

    it 'returns status code 400(Bad request)' do
      subject
      expect(response).to have_http_status(400)
    end
  end
end
