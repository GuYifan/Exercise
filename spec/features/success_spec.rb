require "rails_helper"
require_relative Rails.root.join('spec', 'support', 'context', 'test_context.rb')
require_relative Rails.root.join('spec', 'support', 'helpers', 'waiter.rb')

RSpec.feature "Static elements/view", :type => :feature do
  # shared stuff between all feature specs to reduce duplicate code
  include_context 'test_context'

  describe "Successful tests" do
    before(:each) do
      go_to_base_page
    end

    context "Not logged in" do
      scenario "Non-existent user can't log in." do
        # go to log in page and try to log in with a non-existent user
        base_page.go_to_login
        # wait until the page finishes loading before action
        TestHelper::wait_until_present(login_page.login_form)

        # log in with invalid credentials
        login_page.login("123@123","123")

        # verify if the correct error message is shown
        expect(login_page.success_notification).to have_text("Invalid Email or password.")
        # further to check if the cart is still not visible
        expect(page.all('li a', text: 'Logout').size).to eq(0)
      end

      scenario "User can sign up successfully" do
        base_page.go_to_sign_up
        TestHelper::wait_until_present(login_page.login_form)

        @@new_user = (0...10).map { ('a'..'z').to_a[rand(26)] }.join + '@test'
        @@new_password = (0...10).map { ('a'..'z').to_a[rand(26)] }.join
        sign_up_page.sign_up(@@new_user, @@new_password)

        expect(sign_up_page.success_notification).to have_text("Welcome! You have signed up successfully.")
        expect(sign_up_page.warning_notification).to have_text("You do not have any orders yet.")
        expect(sign_up_page.nav_bar.pages.logout.visible?).to eq(true)
        expect(page.all('li a', text: 'Cart').size).to eq(0)
      end
    end

    context "Logged in" do
      before(:all) do
        # TODO: if i can manage rspec to run in test environemnt then just need to use this user created by factory bot to log in
        @user1 = create(:user)
      end

      scenario "User can see all available icecream, add to cart and place order" do
        # because of above, i'll just create a new user for each logged in test
        # or the workaround is to create a dedicated user in development environemnt and use that
        # but ultimately using factorybot as mentioned above is the most ideal
        base_page.go_to_sign_up
        TestHelper::wait_until_present(login_page.login_form)
        tmp_email = (0...10).map { ('a'..'z').to_a[rand(26)] }.join + '@test'
        tmp_password = (0...10).map { ('a'..'z').to_a[rand(26)] }.join
        sign_up_page.sign_up(tmp_email, tmp_password)

        base_page.go_to_icecream
        TestHelper::wait_until_present(ice_cream_page.page_title)

        # check the display
        expect(ice_cream_page.items.entry.size).to eq(4)
        expect(ice_cream_page.items.entry(text: 'COCONUT').size).to eq(1)
        expect(ice_cream_page.items.entry(text: 'GUAVA').size).to eq(1)
        expect(ice_cream_page.items.entry(text: 'COFFEE').size).to eq(1)
        expect(ice_cream_page.items.entry(text: 'COCONUT').first.add_to_cart_button.present?).to eq(true)
        expect(ice_cream_page.items.entry(text: 'GUAVA').first.add_to_cart_button.present?).to eq(true)
        expect(ice_cream_page.items.entry(text: 'COFFEE').first.add_to_cart_button.present?).to eq(true)

        # add items to cart
        # ice_cream_page.items.entry(text: 'COCONUT').first.add_to_cart_button.click
        # ice_cream_page.items.entry(text: 'COFFEE').first.add_to_cart_button.click
        # ice_cream_page.items.entry(text: 'GUAVA').first.add_to_cart_button.click

        # above not working because page rerenders after each click
        # binding.pry
        page.all('.table tr .btn', text: 'Add to Cart')[0].click
        sleep(3)
        page.all('.table tr .btn', text: 'Add to Cart')[0].click
        sleep(3)
        page.all('.table tr .btn', text: 'Add to Cart')[0].click
        sleep(3)

        # verify item added
        # binding.pry
        TestHelper::wait_until_present(ice_cream_page.items.entry(text: 'COCONUT').first.remove_from_cart_button)
        expect(ice_cream_page.items.entry(text: 'COCONUT').first.remove_from_cart_button.present?).to eq(true)
        expect(ice_cream_page.items.entry(text: 'COFFEE').first.remove_from_cart_button.present?).to eq(true)
        expect(ice_cream_page.items.entry(text: 'GUAVA').first.remove_from_cart_button.present?).to eq(true)
        # verify cart is available to the user right now
        expect(page.all('li a', text: 'Cart').size).to eq(1)

        # go to cart
        ice_cream_page.go_to_cart
        TestHelper::wait_until_present(cart_page.page_title)
        # verify what's in the cart
        expect(cart_page.items.entry.size).to eq(4)
        expect(cart_page.items.entry(text: 'COCONUT').size).to eq(1)
        expect(cart_page.items.entry(text: 'COFFEE').size).to eq(1)
        expect(cart_page.items.entry(text: 'GUAVA').size).to eq(1)

        # place order
        cart_page.order_button.click
      end
    end
  end
end