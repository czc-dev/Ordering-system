require 'rails_helper'

RSpec.describe 'Ajax::Exams', type: :request, js: true do
  let(:employee) { create(:employee) }
  let!(:patient) { create(:patient) }
  let(:order) { patient.orders.first }
  let(:exam) { order.exams.first }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  describe 'GET /ajax/exams/edit/:id' do
    context 'when exam was created by machine(not employee)' do
      before { get edit_ajax_exam_path(exam.id) }

      it 'can show "Unknown-Employee" as who is set current state of exam' do
        expect(assigns[:originator]).to eq('Unknown-Employee')
      end

      it { should render_template('edit') }
    end

    context 'when exam was updated by employee' do
      let(:valid_params) do
        {
          exam: {
            canceled: true, urgent: true, status_id: 5, sample: 'updated', result: 'updated', booked_at: nil
          }
        }
      end

      before do
        put exam_path(exam.id), params: valid_params
        get edit_ajax_exam_path(exam.id)
      end

      with_versioning do
        it "can show employee's name that is set current state of exam" do
          expect(assigns[:originator]).to eq(employee.fullname)
        end

        it { should render_template('edit') }
      end
    end
  end
end
