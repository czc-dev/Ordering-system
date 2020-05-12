RSpec.shared_context :act_login_as_employee do
  let(:employee) { create(:employee) }
  before do
    allow_any_instance_of(ApplicationController).to receive(:current_employee).and_return(employee)
    allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
  end
end

RSpec.shared_context :act_login_as_administrator do
  let(:administrator) { create(:employee, :administrator) }
  before do
    allow_any_instance_of(ApplicationController).to receive(:current_employee).and_return(administrator)
    allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
  end
end
