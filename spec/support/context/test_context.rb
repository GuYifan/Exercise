RSpec.shared_context 'Test context' do
  let(:base_page)  { BasePage.new }
  let(:home_order_page)  { HomeOrderPage.new }
  let(:ice_cream_page)  { IceCreamPage.new }
  let(:login_page)  { LoginPage.new }
  let(:sign_up_page)  { SignUpPage.new }

  def go_to_base_page
    base_page.load
  end
end