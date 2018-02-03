require_relative Rails.root.join('spec', 'support', 'page_objects', 'base_page.rb')
require_relative Rails.root.join('spec', 'support', 'page_objects', 'home_page.rb')
require_relative Rails.root.join('spec', 'support', 'page_objects', 'icecream_page.rb')
require_relative Rails.root.join('spec', 'support', 'page_objects', 'login_page.rb')
require_relative Rails.root.join('spec', 'support', 'page_objects', 'sign_up_page.rb')

RSpec.shared_context 'test_context' do
  let(:base_page)  { BasePage.new }
  let(:home_order_page)  { HomeOrderPage.new }
  let(:ice_cream_page)  { IceCreamPage.new }
  let(:login_page)  { LoginPage.new }
  let(:sign_up_page)  { SignUpPage.new }

  def go_to_base_page
    visit base_page.url
  end
end