require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # self.use_instantiated_fixtures = true
  # def test_the_truth
  #   assert true
  # end

  @@valid_user_with_record = 1
  @@valid_user_id_with_no_record = 3
  @@invalid_user_id = 100
  @@invalid_input = 'r@ndom'

  test "with an existent user id & some shopping records" do
    order_details = Order.user_order_stats(@@valid_user_with_record)
    # binding.pry
    # puts order_details

    assert_not_nil(order_details, "Failed! user_order_stats returns null!")
    assert_equal(order_details.length, 3, "Failed! Response doesn't contain expect contents!")
    assert_equal(order_details[0].length, 5, "Failed! Array of all ordered names doesn't contain correct number of items!")
    assert(order_details[0].include?("Orange"), "Failed! Orange is not included in the response as it's supposed to!")
    assert(order_details[0].include?("Coconut"), "Failed! Coconut is not included in the response as it's supposed to!")
    assert(order_details[0].include?("Coffee"), "Failed! Coffee is not included in the response as it's supposed to!")
    assert(order_details[0].include?("Chocolate"), "Failed! Chocolate is not included in the response as it's supposed to!")
    assert(order_details[0].include?("Grape"), "Failed! Grape is not included in the response as it's supposed to!")
    assert_equal(order_details[1], 5, "Failed! quantity of uniq items ordered is wrong!")
    assert_equal(order_details[2], 14, "Failed! quantity of all items ordered * 2 is wrong!")
  end

  test "with an existent user id & NO shopping records" do
    assert_nil(Order.user_order_stats(@@valid_user_id_with_no_record), "Failed! user_order_stats returns something rather than null!")
  end

  test "with a non-existent user id" do
    # TODO: not sure why assert_nothing_raised is not working.
    # assert_nothing_raised(NoMethodError) do
    #   Order.user_order_stats(@@invalid_user_id)
    # end

    begin
      Order.user_order_stats(@@invalid_user_id)
    rescue Exception
      assert(false, "Failed! user_order_stats threw exception when given a non-existent user id!")
    end

    assert_nil(Order.user_order_stats(@@invalid_user_id), "Failed! user_order_stats returns something rather than null!")
  end

  test "with invalid input" do
    begin
      Order.user_order_stats(@@invalid_input)
    rescue Exception
      assert(false, "Failed! user_order_stats threw exception when given an invalid input!")
    end

    assert_nil(Order.user_order_stats(@@invalid_input), "Failed! user_order_stats returns something rather than null!")
  end
end
