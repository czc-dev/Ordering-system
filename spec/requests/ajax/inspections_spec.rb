require 'rails_helper'

RSpec.describe 'Ajax::Inspections', type: :request, js: true do
  let(:employee) { create(:employee) }
  let!(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:inspection) { order.inspections.first }

  # all actions are requied logged in
  before { post login_path, params: { username: employee.username, password: employee.password } }

  describe 'GET /ajax/inspections/edit/:id' do
    context 'when inspection was created by machine(not employee)' do
      before { get edit_ajax_inspection_path(inspection.id) }

      it 'can show "Unknown-Employee" as who is set current state of inspection' do
        expect(assigns[:originator]).to eq('Unknown-Employee')
      end

      it { should render_template('edit') }
    end

    context 'when inspection was updated by employee' do
      let(:valid_params) do
        {
          inspection: {
            canceled: true, urgent: true, status_id: 5, sample: 'updated', result: 'updated', booked_at: nil
          }
        }
      end

      before do
        put inspection_path(inspection.id), params: valid_params
        get edit_ajax_inspection_path(inspection.id)
      end

      it "can show employee's name that is set current state of inspection" do
        expect(assigns[:originator]).to eq(employee.fullname)
      end

      it { should render_template('edit') }
    end
  end
end
