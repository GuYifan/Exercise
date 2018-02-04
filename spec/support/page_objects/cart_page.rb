class CartPage < BasePage
  element :page_title, 'h3', text: 'Your Cart'

  section :items, '.table' do
    sections :entry, 'tr:nth-child(n)' do
      element :name, 'h5'
      element :image, 'img'
      element :remove_from_cart_button, '.btn', text: 'Remove from Cart'
    end
  end

  element :order_button, '.btn.btn-success',  text: 'Order'
end