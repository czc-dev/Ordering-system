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
    let(:set_ids) { (1..5).to_a }
    let(:params) do
      { inspection_detail: { formal_name: 'Must present', inspection_sets: set_ids } }
    end

    before { post inspection_details_path, params: params }

    it 'assigns relations to inspection sets for created inspection detail' do
      assigned_sets = InspectionDetail.last.inspection_sets
      base_sets     = InspectionSet.where(id: set_ids)
      expect((assigned_sets & base_sets).size).to eq(set_ids.size)
    end
  end
end
