# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /inspection_sets', type: :request, js: true do
  # WARNING: 稀に Faker::Internet.username で生成した擬似ユーザー名が衝突する場合があります
  let!(:administor) { create(:administor) }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: administor.username, password: administor.password } }

  context 'when request is valid' do
    let(:params) do
      { inspection_set: { set_name: 'Must present' } }
    end

    before { post inspection_sets_path, params: params }

    it 'creates new inspection_set' do
      # リダイレクト先のアクション 'show' にて最新のものを表示していること
      expect(assigns[:inspection_set]).to eq(InspectionSet.last)
    end

    it { should redirect_to(inspection_set_path(InspectionSet.last.id)) }
  end

  context 'when request is invalid' do
    let(:params) do
      { inspection_set: { set_name: '' } }
    end

    before { post inspection_sets_path, params: params }

    it { should render_template('new') }
  end

  context 'when require is specified relations to inspection detail' do
    let(:detail_ids) { (1..5).to_a }
    let(:params) do
      { inspection_set: { set_name: 'Must present', inspection_details: detail_ids } }
    end

    before { post inspection_sets_path, params: params }

    it 'assigns relations to inspection details for created inspection set' do
      assigned_details = InspectionSet.last.inspection_details
      base_details     = InspectionDetail.where(id: detail_ids)
      expect((assigned_details & base_details).size).to eq(detail_ids.size)
    end
  end
end
