class HomeOrderPage < BasePage
  section :order_history, '.table-responsiv' do
    element :header, 'tr:nth-child(1)'
    sections :orders, 'tr:nth-child(n+1)' do
      element :item_ids,  'td:nth-child(1)'
      element :date,  'td:nth-child(2)'
    end
  end
end