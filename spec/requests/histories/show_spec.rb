# frozen_string_literal: true

RSpec.describe 'Histories (PaperTrail::Version) GET /histories/:id', type: :request, js: true do
  let(:employee) { create(:employee) }
  let(:patient) { create(:patient) }
  let(:create_params) do
    { order: { exam_item_ids: (1..10).to_a, may_result_at: Time.zone.now + 10.days } }
  end

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_employee).and_return(employee)
    allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
  end

  context 'when history has only 1 version (after created)' do
    subject do
      post patient_orders_path(patient.id), params: create_params
      get history_path(PaperTrail::Version.last)
    end

    with_versioning do
      it { is_expected.to render_template('show') }

      it 'cannot show object\'s difference; it can only show "create" and "current" message' do
        subject
        expect(assigns[:history]&.previous).to be_nil
        expect(assigns[:history]&.next).to     be_nil
      end

      it 'can show employee that changed this resource' do
        subject
        expect(assigns[:version_author]).to eq(employee)
      end
    end
  end

  context 'when history has previous version (e.g. create → update)' do
    subject do
      post patient_orders_path(patient.id), params: create_params
      order = patient.orders.first
      put order_path(order.id), params: { order: { canceled: true } }
      get history_path(PaperTrail::Version.last)
    end

    with_versioning do
      it { is_expected.to render_template('show') }

      it 'can show previous state and "current" message' do
        subject
        expect(assigns[:history]&.previous).not_to be_nil
        expect(assigns[:history]&.next).to be_nil
      end

      it 'can show employee that changed this resource' do
        subject
        expect(assigns[:version_author]).to eq(employee)
      end
    end
  end

  context 'when history has previous and next version (e.g. create → update → update)' do
    subject do
      post patient_orders_path(patient.id), params: create_params
      order = patient.orders.first
      put order_path(order.id), params: { order: { canceled: true } }
      put order_path(order.id), params: { order: { canceled: false } }
      get history_path(PaperTrail::Version.order(created_at: :desc).second)
    end

    with_versioning do
      it { is_expected.to render_template('show') }

      it 'can show previous and next state of specific object' do
        subject
        expect(assigns[:history]&.previous).not_to be_nil
        expect(assigns[:history]&.next).not_to be_nil
      end

      it 'can show employee that changed this resource' do
        subject
        expect(assigns[:version_author]).to eq(employee)
      end
    end
  end
end
