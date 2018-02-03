class IceCreamPage < BasePage
  element :page_title, 'h3', text: 'Icecream'

  section :items, '.table' do
    sections :entry, 'tr:nth-child(n)' do
      element :name, 'h5'
      element :image, 'img'
      element :add_to_cart_button, '.btn', text: 'Add to Cart'
      element :remove_from_cart_button, '.btn', text: 'Remove from Cart'
    end
  end

  section :pagination, '.pagination' do
    element :previous_page, '.previous_page'
    element :next_page, '.next_page'
    element :current_page, '.em.current'
  end
end