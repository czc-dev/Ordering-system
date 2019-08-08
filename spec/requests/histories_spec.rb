require 'rails_helper'

RSpec.describe 'Histories (PaperTrail::Version)', type: :request, js: true do
  let(:employee) { create(:employee) }
  let!(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:create_params) do
    { order: { inspections: (1..10).to_a, may_result_at: Time.zone.now + 10.days } }
  end

  # all actions are requied logged in
  before { post login_path, params: { username: employee.username, password: employee.password } }

  describe 'GET /histories' do
    # TODO: 履歴件数が10件以上になるように factory を書き直す（とより厳密なテストになる）
    before { get histories_path }

    with_versioning do
      it 'can list up recent 10 histories of Order' do
        expectation = PaperTrail::Version.where(item_type: 'Order').order(created_at: :desc).first(10)
        expect(assigns[:orders]).to eq(expectation)
      end

      it 'can list up recent 10 histories of Inspection' do
        expectation = PaperTrail::Version.where(item_type: 'Inspection').order(created_at: :desc).first(10)
        expect(assigns[:inspections]).to eq(expectation)
      end
    end

    it { should render_template('index') }
  end

  describe 'GET /histories/:id' do
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
end
