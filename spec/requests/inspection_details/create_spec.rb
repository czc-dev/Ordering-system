# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /inspection_details', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  context 'when request is valid' do
    let(:params) do
      { inspection_detail: { formal_name: 'Must present', abbreviation: 'Optional' } }
    end

    before { post inspection_details_path, params: params }

    it 'creates new inspection_detail' do
      # リダイレクト先のアクション 'show' にて最新のものを表示していること
      expect(assigns[:inspection_detail]).to eq(InspectionDetail.last)
    end

    it { should redirect_to(inspection_detail_path(InspectionDetail.last.id)) }
  end

  context 'when request is invalid' do
    let(:params) do
      { inspection_detail: { formal_name: '' } }
    end

    before { post inspection_details_path, params: params }

    it { should render_template('new') }
  end

  context 'when require is specified relations to inspection set' do
    let(:params) do
      { inspection_detail: { formal_name: 'Must present', inspection_sets: (1..5).to_a } }
    end

    it 'assigns inspection sets to created inspection detail' do
      expect(InspectionDetail.last.inspection_sets).to eq(InspectionSet.where(id: (1..5).to_a))
    end
  end
end
