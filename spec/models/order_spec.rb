require "rails_helper"
require_relative Rails.root.join('spec', 'support', 'helpers', 'waiter.rb')

RSpec.describe Order, :type => :model do
  before(:all) do
    email1 = TestHelper::random + '@' + TestHelper::random
    password1 = TestHelper::random
    email2 = TestHelper::random + '@' + TestHelper::random
    password2 = TestHelper::random

    @user_with_order = User.create!(email: email1, password: password1)
    @user_with_no_order = User.create!(email: email2, password: password2)
  end

  it "with an existent user id & some shopping records" do
    shopitem1 = ShopItem.create!(name: 'apple', img: 'apple.jpeg', item_type: 'juice')
    shopitem2 = ShopItem.create!(name: 'coconut', img: 'coconut.jpeg', item_type: 'icecream')
    order1 = Order.create!(code: shopitem1.id, user_id: @user_with_order.id)
    order2 = Order.create!(code: shopitem2.id, user_id: @user_with_order.id)

    expect(Order.user_order_stats(@user_with_order.id)).to eq([["Apple", "Coconut"], 2, 4])
  end

  it "with an existent user id & NO shopping records" do
    expect(Order.user_order_stats(@user_with_no_order.id).nil?).to eq(true)
  end

  # this one will fail which means there's a bug with the method in the model
  it "with a non-existent user id" do
    expect{Order.user_order_stats('99999999999999999')}.to_not raise_error
  end

  # this one will fail which means there's a bug with the method in the model
  it "with invalid input" do
    expect{Order.user_order_stats('abcdefg')}.to_not raise_error
  end
end