require "rails_helper"
require_relative Rails.root.join('spec', 'support', 'context', 'test_context.rb')
require_relative Rails.root.join('spec', 'support', 'helpers', 'waiter.rb')

RSpec.feature "Static elements/view", :type => :feature do
  # shared stuff between all feature specs to reduce duplicate code
  include_context 'test_context'

  describe "Failed tests" do
    before(:each) do
      go_to_base_page
    end

    context "Not logged in" do
      scenario "Can see all available juice via Juice link in navigation bar" do
        # go to log in page and try to log in with a non-existent user
        base_page.go_to_juice
        # wait until the page finishes loading before action
        TestHelper::wait_until_present(juice_page.page_title)

        # see if all available juice is shown
        expect(ice_cream_page.items.entry.size).to eq(4)
        expect(ice_cream_page.items.entry(text: 'ORANGE').size).to eq(1)
        expect(ice_cream_page.items.entry(text: 'APPLE').size).to eq(1)
        expect(ice_cream_page.items.entry(text: 'GRAPE').size).to eq(1)
      end
    end

    context "Logged in" do
      before(:all) do
        # TODO: if i can manage rspec to run in test environemnt then just need to use this user created by factory bot to log in
        @user1 = create(:user)
      end

      scenario "User can remove items from cart" do
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
        page.all('.table tr .btn', text: 'Add to Cart')[0].click
        sleep(3)

        # verify item added
        TestHelper::wait_until_present(ice_cream_page.items.entry(text: 'COCONUT').first.remove_from_cart_button)
        expect(ice_cream_page.items.entry(text: 'COCONUT').first.remove_from_cart_button.present?).to eq(true)
        # verify cart is available to the user right now
        expect(page.all('li a', text: 'Cart').size).to eq(1)

        # go to cart
        ice_cream_page.go_to_cart
        TestHelper::wait_until_present(cart_page.page_title)
        # verify what's in the cart
        expect(cart_page.items.entry.size).to eq(2)
        expect(cart_page.items.entry(text: 'COCONUT').size).to eq(1)

        # now remove it from cart
        ice_cream_page.items.entry(text: 'COCONUT').first.remove_from_cart_button.click
        # check if cart is empty
        expect(sign_up_page.success_notification).to have_text("Your cart is empty.")
      end
    end
  end
end