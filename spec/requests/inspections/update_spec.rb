# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Inspections PATCH/PUT /inspection/:id/', type: :request, js: true do
  let(:employee) { create(:employee) }
  let(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:inspection) { order.inspections.first }

  # all actions are requied logged in
  before { post login_path, params: { username: employee.username, password: employee.password } }

  let(:default_params) do
    {
      inspection: {
        canceled: false,
        urgent: false,
        submitted: false,
        status_id: 0,
        sample: '',
        result: '',
        appraisal: '',
        booked_at: nil
      }
    }
  end

  context 'when updated' do
    before { put inspection_path(inspection.id), params: default_params }

    it { should redirect_to(order_inspections_url(inspection.order.id)) }
  end

  context 'when booked' do
    before do
      put inspection_path(inspection.id),
          params: default_params.merge(inspection: { booked_at: Time.zone.now + 1.week })
    end

    it 'sets status to "Booked"' do
      updated_inspection = Inspection.find(inspection.id)
      expect(updated_inspection.status_id).to eq(1)
    end
  end

  context 'when colleced sample BUT did not submit' do
    before do
      put inspection_path(inspection.id),
          params: default_params.merge(inspection: { sample: 'collected' })
    end

    it 'sets status to "Sample collected"' do
      updated_inspection = Inspection.find(inspection.id)
      expect(updated_inspection.status_id).to eq(2)
    end
  end

  context 'when collected sample AND submitted' do
    before do
      put inspection_path(inspection.id),
          params: default_params.merge(inspection: { sample: 'collected', submitted: true })
    end

    it 'sets status to "Unresult"' do
      updated_inspection = Inspection.find(inspection.id)
      expect(updated_inspection.status_id).to eq(3)
    end
  end

  context 'when updated result' do
    before do
      put inspection_path(inspection.id),
          params: default_params.merge(inspection: { result: 'resulted' })
    end

    it 'sets status to "Resulted"' do
      updated_inspection = Inspection.find(inspection.id)
      expect(updated_inspection.status_id).to eq(4)
    end
  end

  context 'when updated appraisal' do
    before do
      put inspection_path(inspection.id),
          params: default_params.merge(inspection: { appraisal: 'appraised' })
    end

    it 'sets status to "Appraised"' do
      updated_inspection = Inspection.find(inspection.id)
      expect(updated_inspection.status_id).to eq(5)
    end
  end
end
