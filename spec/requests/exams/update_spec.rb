# frozen_string_literal: true

RSpec.describe 'Exams PATCH/PUT /exams/:id/', type: :request, js: true do
  let(:exam) { create(:exam) }

  include_context :act_login_as_employee

  let(:params) do
    {
      exam: {
        canceled: false,
        urgent: false,
        submitted: false,
        status: 0,
        sample: '',
        result: '',
        appraisal: '',
        booked_at: nil
      }
    }
  end

  context 'when updated' do
    subject { put exam_path(exam.id), params: params }

    it { is_expected.to redirect_to(order_exams_url(exam.order.id)) }
  end

  context 'when booked' do
    subject do
      put exam_path(exam.id),
          params: params.deep_merge(exam: { booked_at: Time.zone.now + 1.week })
    end

    it 'sets status to "Booked"' do
      subject
      expect(exam.reload.status).to eq('booked')
    end
  end
  context 'when colleced sample BUT did not submit' do
    subject do
      put exam_path(exam.id),
          params: params.deep_merge(exam: { sample: 'collected' })
    end

    it 'sets status to "Sample collected"' do
      subject
      expect(exam.reload.status).to eq('sampled')
    end
  end

  context 'when collected sample AND submitted' do
    subject do
      put exam_path(exam.id),
          params: params.deep_merge(exam: { sample: 'collected', submitted: true })
    end

    it 'sets status to "Unresult"' do
      subject
      expect(exam.reload.status).to eq('unresulted')
    end
  end

  context 'when updated result' do
    subject do
      put exam_path(exam.id),
          params: params.deep_merge(exam: { result: 'resulted' })
    end

    it 'sets status to "Resulted"' do
      subject
      expect(exam.reload.status).to eq('resulted')
    end
  end

  context 'when updated appraisal' do
    subject do
      put exam_path(exam.id),
          params: params.deep_merge(exam: { appraisal: 'appraised' })
    end

    it 'sets status to "Appraised"' do
      subject
      expect(exam.reload.status).to eq('appraised')
    end
  end
end
