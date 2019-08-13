require 'rails_helper'

RSpec.describe 'Ajax::Orders', type: :request, js: true do
  let(:employee) { create(:employee) }
  let!(:patient) { create(:patient) }
  let(:order) { patient.orders.first }

  # 全てのアクションにおいてログインが必要です
  before { post login_path, params: { username: employee.username, password: employee.password } }

  describe 'GET /ajax/orders/edit/:id' do
    context 'when order was created by machine(not employee)' do
      before { get edit_ajax_order_path(order.id) }

      it 'can show "Unknown-Employee" as who is set current state of order' do
        expect(assigns[:originator]).to eq('Unknown-Employee')
      end

      it { should render_template('edit') }
    end

    context 'when order was updated by employee' do
      let(:valid_params) do
        { order: { canceled: true } }
      end

      before do
        put order_path(order.id), params: valid_params
        get edit_ajax_order_path(order.id)
      end

      with_versioning do
        it "can show employee's name that is set current state of order" do
          expect(assigns[:originator]).to eq(employee.fullname)
        end

        it { should render_template('edit') }
      end
    end
  end
end
