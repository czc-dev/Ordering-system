# frozen_string_literal: true

RSpec.describe 'Exams PATCH/PUT /exams/:id/', type: :request, js: true do
  let(:employee) { create(:employee) }
  let(:exam) { create(:exam) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  let(:default_params) do
    {
      exam: {
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
    before { put exam_path(exam.id), params: default_params }

    it { should redirect_to(order_exams_url(exam.order.id)) }
  end

  context 'when booked' do
    before do
      put exam_path(exam.id),
          params: default_params.merge(exam: { booked_at: Time.zone.now + 1.week })
    end

    it 'sets status to "Booked"' do
      updated_exam = Exam.find(exam.id)
      expect(updated_exam.status_id).to eq(1)
    end
  end

  context 'when colleced sample BUT did not submit' do
    before do
      put exam_path(exam.id),
          params: default_params.merge(exam: { sample: 'collected' })
    end

    it 'sets status to "Sample collected"' do
      updated_exam = Exam.find(exam.id)
      expect(updated_exam.status_id).to eq(2)
    end
  end

  context 'when collected sample AND submitted' do
    before do
      put exam_path(exam.id),
          params: default_params.merge(exam: { sample: 'collected', submitted: true })
    end

    it 'sets status to "Unresult"' do
      updated_exam = Exam.find(exam.id)
      expect(updated_exam.status_id).to eq(3)
    end
  end

  context 'when updated result' do
    before do
      put exam_path(exam.id),
          params: default_params.merge(exam: { result: 'resulted' })
    end

    it 'sets status to "Resulted"' do
      updated_exam = Exam.find(exam.id)
      expect(updated_exam.status_id).to eq(4)
    end
  end

  context 'when updated appraisal' do
    before do
      put exam_path(exam.id),
          params: default_params.merge(exam: { appraisal: 'appraised' })
    end

    it 'sets status to "Appraised"' do
      updated_exam = Exam.find(exam.id)
      expect(updated_exam.status_id).to eq(5)
    end
  end
end
