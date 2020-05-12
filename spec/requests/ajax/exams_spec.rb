# frozen_string_literal: true

RSpec.describe 'Ajax::Exams', type: :request, js: true do
  let(:order) { exam.order }
  let!(:exam) { create(:exam) }

  include_context :act_login_as_employee

  describe 'GET /ajax/exams/index' do
    subject { get ajax_exams_path, params: params }

    context 'when params: canceled specified' do
      let(:params) { { order_id: order.id, page: 1, canceled: 1 } }

      it 'can show first page of exams with canceled' do
        subject
        expect(assigns[:exams]).to eq(order.exams_with_detail.page(params[:page]))
      end
    end

    context 'when params: canceled not specified' do
      let(:params) { { order_id: order.id, page: 1, canceled: 0 } }

      it 'can show first page of exams without canceled' do
        subject
        expect(assigns[:exams]).to eq(order.exams_only_active.page(params[:page]))
      end
    end
  end

  describe 'GET /ajax/exams/edit/:id' do
    context 'when exam was updated by employee' do
      let(:params) do
        {
          exam: {
            canceled: true, urgent: true, status: 5, sample: 'updated', result: 'updated', booked_at: nil
          }
        }
      end

      subject do
        put exam_path(exam.id), params: params
        get edit_ajax_exam_path(exam.id)
      end

      with_versioning do
        it "can show employee's name that is set current state of exam" do
          subject
          expect(assigns[:originator]).to eq(employee.fullname)
        end

        it { is_expected.to render_template('edit') }
      end
    end
  end
end
