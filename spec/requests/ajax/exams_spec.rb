# frozen_string_literal: true

RSpec.describe 'Ajax::Exams', type: :request, js: true do
  let(:employee) { create(:employee) }
  let(:order) { exam.order }
  let!(:exam) { create(:exam) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  describe 'GET /ajax/exams/index' do
    context 'when params: canceled specified' do
      before { get ajax_exams_path, params: params }

      let(:params) { { order_id: order.id, page: 1, canceled: 1 } }

      it 'can show first page of exams with canceled' do
        expect(assigns[:exams]).to eq(order.exams_with_detail.page(params[:page]))
      end
    end

    context 'when params: canceled not specified' do
      before { get ajax_exams_path, params: params }

      let(:params) { { order_id: order.id, page: 1, canceled: 0 } }

      it 'can show first page of exams without canceled' do
        expect(assigns[:exams]).to eq(order.exams_only_active.page(params[:page]))
      end
    end
  end

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
