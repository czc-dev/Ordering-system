# frozen_string_literal: true

RSpec.describe 'Histories (PaperTrail::Version) GET /histories/:id', type: :request, js: true do
  let(:employee) { create(:employee) }
  let(:patient) { order.patient }
  let(:order) { create(:order) }
  let(:create_params) do
    { order: { exams: (1..10).to_a, may_result_at: Time.zone.now + 10.days } }
  end

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  context 'when history has only 1 version (after created)' do
    before do
      post patient_orders_path(patient.id), params: create_params
      get history_path(PaperTrail::Version.last)
    end

    with_versioning do
      it 'cannot show object\'s difference; it can only show "create" and "current" message' do
        expect(assigns[:history]&.previous).to be_nil
        expect(assigns[:history]&.next).to     be_nil
      end

      it 'can show employee that changed this resource' do
        expect(assigns[:version_author]).to eq(employee)
      end
    end
  end

  context 'when history has previous version (e.g. create → update)' do
    let(:update_params) { { order: { canceled: true } } }

    before do
      post patient_orders_path(patient.id), params: create_params
      put order_path(order.id), params: update_params
      get history_path(PaperTrail::Version.last)
    end

    with_versioning do
      it 'can show previous state and "current" message' do
        expect(assigns[:history]&.previous).not_to be_nil
        expect(assigns[:history]&.next).to be_nil
      end

      it 'can show employee that changed this resource' do
        expect(assigns[:version_author]).to eq(employee)
      end
    end
  end

  context 'when history has previous and next version (e.g. create → update → update)' do
    before do
      post patient_orders_path(patient.id), params: create_params
      put order_path(order.id), params: { order: { canceled: true } }
      put order_path(order.id), params: { order: { canceled: false } }
      get history_path(PaperTrail::Version.order(created_at: :desc).second)
    end

    with_versioning do
      it 'can show previous and next state of specific object' do
        expect(assigns[:history]&.previous).not_to be_nil
        expect(assigns[:history]&.next).not_to be_nil
      end

      it 'can show employee that changed this resource' do
        expect(assigns[:version_author]).to eq(employee)
      end
    end
  end
end
