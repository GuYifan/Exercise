class BasePage < SitePrism::Page
  set_url 'http://localhost:3000'

  section :nav_bar, '.navbar' do
    element :logo_button, '.navbar-brand'
    section :pages, '.navbar-nav' do
      element :home_page, 'a', text: 'Home'
      element :juice, 'a', text: 'Juice'
      element :icecream, 'a', text: 'Icecream'
      element :all_categories, 'a', text: 'All Categories'
      element :login, 'a', text: 'Login'
      element :sign_up, 'a', text: 'Signup'
      element :cart, 'a', text: 'Cart'
      element :logout, 'a', text: 'Logout'
    end
  end

  element :success_notification,  '.alert-success'
  element :warning_notification,  '.alert.bg-danger'

  def click_brand
    nav_bar.logo_button.click
  end

  def go_to_home
    nav_bar.pages.home_page.click
  end

  def go_to_juice
    nav_bar.pages.juice.click
  end

  def go_to_icecream
    nav_bar.pages.icecream.click
  end

  def go_to_all_categories
    nav_bar.pages.all_categories.click
  end

  def go_to_login
    nav_bar.pages.login.click
  end

  def go_to_sign_up
    nav_bar.pages.sign_up.click
  end

  def go_to_cart
    nav_bar.pages.cart.click
  end

  def logout
    nav_bar.pages.logout.click
  end
end