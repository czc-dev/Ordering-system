# frozen_string_literal: true

RSpec.describe 'Histories (PaperTrail::Version) GET /histories', type: :request, js: true do
  let(:employee) { create(:employee) }

  # 全てのアクションにおいてログインが必要です
  before do
    post login_path, params: { username: employee.username, password: employee.password }
  end

  subject do
    create_list(:order, 10)
    get histories_path
  end

  with_versioning do
    it 'can list up recent 10 histories of Order' do
      subject
      expectation = PaperTrail::Version.where(item_type: 'Order').order(created_at: :desc).first(10)
      expect(assigns[:orders]).to eq(expectation)
    end

    it 'can list up recent 10 histories of Exam' do
      subject
      expectation = PaperTrail::Version.where(item_type: 'Exam').order(created_at: :desc).first(10)
      expect(assigns[:exams]).to eq(expectation)
    end
  end

  it { should render_template('index') }
end
