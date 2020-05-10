# frozen_string_literal: true

RSpec.describe 'ExamItems GET /exam_items', type: :request, js: true do
  let(:params) { { page: 1 } }

  include_context :act_login_as_administrator

  before { get exam_items_path, params: params }

  it 'can show all exam_items on first page' do
    expect(assigns[:exam_items]).to eq(ExamItem.page(params[:page]))
  end

  it { should render_template('index') }
end
