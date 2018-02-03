require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  # this is to test in dev environment because i'm not sure how to do FactoryBot outside RSpec
  # thus everything in qatest_dev DB is used here

  @@base_url = 'http://localhost:3000'
  @@user_sign_in = '/users/sign_in'
  @@user_sign_up = '/users/sign_up'
  @@user_email = 'test@test'
  @@user_pwd = 'testtest'

  # this kind of test also can apply to other links in the navigation bar
  # First part to test the navigation bar and display
  test "home page via Home link when logged out" do
    visit @@base_url
    click_on 'Home'

    assert_text 'Login/Signup first'
  end

  test "adding a new user" do
    useremail = (0...9).map { ('a'..'z').to_a[rand(26)] }.join + '@test'
    userpassword = (0...9).map { ('a'..'z').to_a[rand(26)] }.join
    visit (@@base_url + @@user_sign_up)
    fill_in 'user_email', with: useremail
    fill_in 'user_password', with: userpassword
    fill_in 'user_password_confirmation', with: userpassword
    click_on 'Sign up'

    # here also can check other contents of the page
    assert_text 'Welcome! You have signed up successfully.'
  end

  # assume test@test exists in dev DB
  test "user can log in and log out successfully" do
    # first test sign in page
    visit (@@base_url + @@user_sign_in)
    fill_in 'user_email', with: @@user_email
    fill_in 'user_password', with: @@user_pwd
    click_on 'Sign in'

    assert_text 'Signed in successfully.'

    # now test log out
    click_on 'Logout'

    # check if the nav bar is still displayed correctly
    assert_selector('nav', count: 1)
  end

  # assume test@test exists in dev DB
  # this test will fail because there's a bug that user can't remove the last item from cart
  test "user can add and remove item to cart successfully" do
    # first test sign in page
    visit (@@base_url + @@user_sign_in)
    fill_in 'user_email', with: @@user_email
    fill_in 'user_password', with: @@user_pwd
    click_on 'Sign in'

    assert_text 'Signed in successfully.'

    # now add some icecream
    click_on 'Icecream'

    # check if the all kinds of icecream are still displayed correctly
    assert_selector('tr', text: 'COCONUT', count: 1)
    assert_selector('tr', text: 'GUAVA', count: 1)
    assert_selector('tr', text: 'COFFEE', count: 1)

    # add the first one to cart
    page.all('tr td:nth-child(3) a')[0].click

    # check if the button is updated
    assert_selector('.btn.btn-danger', text: "Remove from Cart", count: 1)
    # check if cart is shown
    assert_selector('.nav a', text: "Cart", count: 1)

    # now remove it from the cart
    find('.nav a', text: "Cart").click

    # check if there's one item in cart
    assert_selector('.btn.btn-danger', text: "Remove from Cart", count: 1)
    # now remove it
    find('.btn.btn-danger', text: "Remove from Cart").click

    # verify if cart is empty
    assert_selector('.btn.btn-danger', text: "Remove from Cart", count: 0)
    assert_text('Your cart is empty!')
  end
end
