class BasePage < SitePrism::Page
  set_url '/#'

  section :nav_bar, '.navbar' do
    element :logo_button, '.navbar-brand'
    section :pages, '.navbar-nav' do
      element :home_page, 'a', text: 'Home'
      element :home_page, 'a', text: 'Juice'
      element :home_page, 'a', text: 'Icecream'
      element :home_page, 'a', text: 'All Categories'
      element :home_page, 'a', text: 'Login'
      element :home_page, 'a', text: 'Signup'
      element :home_page, 'a', text: 'Cart'
      element :home_page, 'a', text: 'Logout'
    end
  end

  element :success_notification,  '.alert-success'
end